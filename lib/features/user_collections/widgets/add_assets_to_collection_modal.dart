import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/features/user_collections/widgets/collection_autocomplete_field.dart';
import 'package:tmz_damz/features/user_collections/widgets/collection_details.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class AddAssetsToCollectionModal extends StatefulWidget {
  final ThemeData theme;
  final String? title;
  final String confirmButtonLabel;
  final VoidCallback onCancel;
  final void Function(String collectionID) onConfirm;

  const AddAssetsToCollectionModal({
    super.key,
    required this.theme,
    this.title,
    this.confirmButtonLabel = 'Add',
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<AddAssetsToCollectionModal> createState() =>
      _AddAssetsToCollectionModalState();
}

class _AddAssetsToCollectionModalState
    extends State<AddAssetsToCollectionModal> {
  CollectionModel? _selectedCollection;

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
          _buildTitle(widget.title ?? 'Add selected assets to collection...'),
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
                            setState(() {
                              _selectedCollection = null;
                            });
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
        _buildCollectionLookup(),
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
                if (model == null) {
                  Toast.showNotification(
                    showDuration: const Duration(seconds: 3),
                    type: ToastTypeEnum.warning,
                    message: 'You must select a collection first.',
                  );
                } else {
                  widget.onConfirm(model.id);
                }
              },
              style: widget.theme.textButtonTheme.style,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  widget.confirmButtonLabel,
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
