import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/features/user_collections/widgets/collection_autocomplete_field.dart';
import 'package:tmz_damz/features/user_collections/widgets/collection_details.dart';
import 'package:tmz_damz/features/user_collections/widgets/new_collection_form.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class NewCollectionParams {
  final String name;
  final String description;
  final bool isPrivate;
  final bool autoClear;

  NewCollectionParams({
    required this.name,
    required this.description,
    required this.isPrivate,
    required this.autoClear,
  });
}

class AddCollectionToFavoritesModal extends StatefulWidget {
  final ThemeData theme;
  final AccessControlPermissionMapModel? permissions;
  final VoidCallback onCancel;
  final void Function(String collectionID) onAdd;
  final void Function(NewCollectionParams params) onCreate;

  const AddCollectionToFavoritesModal({
    super.key,
    required this.theme,
    required this.permissions,
    required this.onCancel,
    required this.onAdd,
    required this.onCreate,
  });

  @override
  State<AddCollectionToFavoritesModal> createState() =>
      _AddCollectionToFavoritesModalState();
}

class _AddCollectionToFavoritesModalState
    extends State<AddCollectionToFavoritesModal> {
  final _isNewController = ValueNotifier<bool>(false);

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final ValueNotifier<bool> _isPrivateController;
  late final ValueNotifier<bool> _autoClearController;

  CollectionModel? _selectedCollection;

  @override
  void dispose() {
    _isNewController.dispose();

    _nameController.dispose();
    _descriptionController.dispose();
    _isPrivateController.dispose();
    _autoClearController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _isPrivateController = ValueNotifier<bool>(
      !(widget.permissions?.collections.canCreate ?? false),
    );
    _autoClearController = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1D1E1F),
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: kElevationToShadow[8],
        color: const Color(0xFF232323),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle('Add collection to favorites...'),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              top: 30.0,
              right: 40.0,
              bottom: 10.0,
            ),
            child: FocusScope(
              child: _buildContent(),
            ),
          ),
          if (_selectedCollection != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                top: 20.0,
                right: 40.0,
              ),
              child: CollectionDetails(
                model: _selectedCollection!,
              ),
            ),
          _buildDialogButtons(_selectedCollection),
        ],
      ),
    );
  }

  Widget _buildCollectionLookup() {
    return Row(
      children: [
        Text(
          'Collection',
          style: widget.theme.textTheme.bodySmall,
          softWrap: false,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: (_selectedCollection != null)
              ? Stack(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _selectedCollection = null;
                            setState(() {});
                          },
                          icon: Icon(
                            MdiIcons.close,
                            color: const Color(0xDEFFFFFF),
                            size: 22,
                          ),
                        ),
                      ),
                      initialValue: _selectedCollection!.name,
                      readOnly: true,
                    ),
                  ],
                )
              : CollectionAutocompleteField(
                  onSelectionChanged: (model) {
                    setState(() {
                      _selectedCollection = model;
                    });
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Choice.inline(
            value: [_isNewController.value],
            itemCount: 2,
            itemBuilder: (state, index) {
              final isNew = index == 1;

              return ChoiceChip(
                label: Text(
                  isNew ? 'New' : 'Existing',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                selected: _isNewController.value == isNew,
                selectedColor: const Color(0xFF8E0000),
                onSelected: (value) {
                  state.replace([isNew]);
                },
              );
            },
            listBuilder: ChoiceList.createScrollable(
              spacing: 10,
            ),
            onChanged: (value) {
              setState(() {
                _isNewController.value = value.firstOrNull ?? false;
              });
            },
          ),
        ),
        const SizedBox(height: 30.0),
        _isNewController.value
            ? NewCollectionForm(
                permissions: widget.permissions,
                nameController: _nameController,
                descriptionController: _descriptionController,
                isPrivateController: _isPrivateController,
                autoClearController: _autoClearController,
              )
            : _buildCollectionLookup(),
      ],
    );
  }

  Widget _buildDialogButtons(CollectionModel? model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const Spacer(),
          SizedBox(
            width: 100.0,
            child: TextButton(
              onPressed: () {
                if (_isNewController.value) {
                  final name = _nameController.text.trim();

                  if (name.isEmpty) {
                    Toast.showNotification(
                      showDuration: const Duration(seconds: 3),
                      type: ToastTypeEnum.warning,
                      message:
                          'You must enter a Name for the collection first.',
                    );
                  } else {
                    widget.onCreate(
                      NewCollectionParams(
                        name: name,
                        description: _descriptionController.text.trim(),
                        isPrivate: _isPrivateController.value,
                        autoClear: _autoClearController.value,
                      ),
                    );
                  }
                } else {
                  if (model == null) {
                    Toast.showNotification(
                      showDuration: const Duration(seconds: 3),
                      type: ToastTypeEnum.warning,
                      message: 'You must select a collection first.',
                    );
                  } else {
                    widget.onAdd(model.id);
                  }
                }
              },
              style: widget.theme.textButtonTheme.style,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'Add',
                  style: widget.theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 100.0,
            child: TextButton(
              onPressed: widget.onCancel,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color(0x30FFFFFF),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                ),
                shape: WidgetStateProperty.resolveWith(
                  (states) {
                    return RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color(0x80000000),
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    );
                  },
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'Cancel',
                  style: widget.theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      color: const Color(0xFF1D1E1F),
      child: Text(
        title,
        style: widget.theme.textTheme.titleSmall?.copyWith(
          color: Colors.blue,
          letterSpacing: 1.0,
        ),
        softWrap: true,
      ),
    );
  }
}
