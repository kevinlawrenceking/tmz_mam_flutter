import 'package:flutter/material.dart';
import 'package:tmz_damz/features/collections/widgets/new_collection_form.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class NewCollectionParams {
  final String name;
  final String description;
  final bool isPrivate;
  final bool autoClear;
  final bool addToFavorites;

  NewCollectionParams({
    required this.name,
    required this.description,
    required this.isPrivate,
    required this.autoClear,
    required this.addToFavorites,
  });
}

class CreateCollectionModal extends StatefulWidget {
  final ThemeData theme;
  final VoidCallback onCancel;
  final void Function(NewCollectionParams params) onCreate;

  const CreateCollectionModal({
    super.key,
    required this.theme,
    required this.onCancel,
    required this.onCreate,
  });

  @override
  State<CreateCollectionModal> createState() => _CreateCollectionModalState();
}

class _CreateCollectionModalState extends State<CreateCollectionModal> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _visibilityController = ValueNotifier<bool>(false);
  final _autoClearController = ValueNotifier<bool>(false);
  final _addToFavoritesController = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _visibilityController.dispose();
    _autoClearController.dispose();
    _addToFavoritesController.dispose();

    super.dispose();
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
          _buildTitle('Create collection...'),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              top: 30.0,
              right: 40.0,
              bottom: 10.0,
            ),
            child: FocusScope(
              child: NewCollectionForm(
                nameController: _nameController,
                descriptionController: _descriptionController,
                visibilityController: _visibilityController,
                autoClearController: _autoClearController,
                addToFavoritesController: _addToFavoritesController,
              ),
            ),
          ),
          _buildDialogButtons(),
        ],
      ),
    );
  }

  Widget _buildDialogButtons() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const Spacer(),
          SizedBox(
            width: 100.0,
            child: TextButton(
              onPressed: () {
                final name = _nameController.text.trim();

                if (name.isEmpty) {
                  Toast.showNotification(
                    showDuration: const Duration(seconds: 3),
                    type: ToastTypeEnum.warning,
                    message: 'You must enter a Name for the collection first.',
                  );
                } else {
                  widget.onCreate(
                    NewCollectionParams(
                      name: name,
                      description: _descriptionController.text.trim(),
                      isPrivate: _visibilityController.value,
                      autoClear: _autoClearController.value,
                      addToFavorites: _addToFavoritesController.value,
                    ),
                  );
                }
              },
              style: widget.theme.textButtonTheme.style,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'Create',
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
                backgroundColor: MaterialStateProperty.all(
                  const Color(0x30FFFFFF),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                ),
                shape: MaterialStateProperty.resolveWith(
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
