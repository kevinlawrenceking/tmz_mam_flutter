import 'package:flutter/material.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/features/collections/widgets/edit_collection_form.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class SaveCollectionParams {
  final String collectionID;
  final String name;
  final String description;
  final bool isPrivate;
  final bool autoClear;

  SaveCollectionParams({
    required this.collectionID,
    required this.name,
    required this.description,
    required this.isPrivate,
    required this.autoClear,
  });
}

class EditCollectionModal extends StatefulWidget {
  final ThemeData theme;
  final AccessControlPermissionMapModel? permissions;
  final CollectionModel model;
  final VoidCallback onCancel;
  final void Function(SaveCollectionParams params) onSave;

  const EditCollectionModal({
    super.key,
    required this.theme,
    required this.permissions,
    required this.model,
    required this.onCancel,
    required this.onSave,
  });

  @override
  State<EditCollectionModal> createState() => _EditCollectionModalState();
}

class _EditCollectionModalState extends State<EditCollectionModal> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final ValueNotifier<bool> _isPrivateController;
  late final ValueNotifier<bool> _autoClearController;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _isPrivateController.dispose();
    _autoClearController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.model.name,
    );
    _descriptionController = TextEditingController(
      text: widget.model.description,
    );
    _isPrivateController = ValueNotifier<bool>(widget.model.isPrivate);
    _autoClearController = ValueNotifier<bool>(widget.model.autoClear);
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
          _buildTitle('Edit collection...'),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              top: 30.0,
              right: 40.0,
              bottom: 10.0,
            ),
            child: FocusScope(
              child: EditCollectionForm(
                permissions: widget.permissions,
                model: widget.model,
                nameController: _nameController,
                descriptionController: _descriptionController,
                isPrivateController: _isPrivateController,
                autoClearController: _autoClearController,
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
                  widget.onSave(
                    SaveCollectionParams(
                      collectionID: widget.model.id,
                      name: name,
                      description: _descriptionController.text.trim(),
                      isPrivate: _isPrivateController.value,
                      autoClear: _autoClearController.value,
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
                  'Save',
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
