// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/features/user_collections/widgets/add_assets_to_collection_modal.dart';
import 'package:tmz_damz/shared/widgets/confirmation_prompt.dart';
import 'package:tmz_damz/utils/config.dart';

class Toolbar extends StatelessWidget {
  final AccessControlPermissionMapModel? permissions;
  final AssetDetailsModel model;
  final void Function(String collectionID, String assetID) onAddToCollection;
  final void Function(String assetID) onDelete;
  final VoidCallback onEdit;

  const Toolbar({
    super.key,
    required this.permissions,
    required this.model,
    required this.onAddToCollection,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF454647),
          ),
          borderRadius: BorderRadius.circular(6.0),
          color: const Color(0xFF353637),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              _buildBackButton(
                context: context,
              ),
              const SizedBox(width: 10.0),
              _buildAddToCollectionButton(
                context: context,
              ),
              const SizedBox(width: 10.0),
              _buildDownloadButton(),
              const Spacer(),
              _buildEditButton(),
              const SizedBox(width: 10.0),
              _buildDeleteButton(
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCollectionButton({
    required BuildContext context,
  }) {
    return SizedBox(
      width: 46,
      child: Opacity(
        opacity: (permissions?.collections.canAddAssets ?? false) ? 1.0 : 0.4,
        child: IconButton(
          onPressed: (permissions?.collections.canAddAssets ?? false)
              ? () {
                  showDialog<void>(
                    context: context,
                    barrierColor: Colors.black54,
                    barrierDismissible: false,
                    builder: (context) {
                      final theme = Theme.of(context);

                      return OverflowBox(
                        minWidth: 600.0,
                        maxWidth: 600.0,
                        child: Center(
                          child: AddAssetsToCollectionModal(
                            theme: theme,
                            title: 'Add asset to collection...',
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                            onConfirm: (collectionID) {
                              onAddToCollection(collectionID, model.id);

                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
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
          icon: Icon(
            MdiIcons.folderPlusOutline,
            color: const Color(0xAEFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton({
    required BuildContext context,
  }) {
    return SizedBox(
      width: 46,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
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
        icon: Transform.flip(
          flipX: true,
          child: Icon(
            MdiIcons.exitToApp,
            color: const Color(0xAEFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton({
    required BuildContext context,
  }) {
    return SizedBox(
      width: 46,
      child: Opacity(
        opacity: (permissions?.assets.canDelete ?? false) ? 1.0 : 0.4,
        child: IconButton(
          onPressed: (permissions?.assets.canDelete ?? false)
              ? () {
                  showConfirmationPrompt(
                    context: context,
                    title: 'Are you sure you want to delete this asset?',
                    message: 'This will delete the asset from DAMZ.',
                    onConfirm: () => onDelete(model.id),
                  );
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
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
          icon: Icon(
            MdiIcons.deleteOutline,
            color: const Color(0xAEFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadButton() {
    return SizedBox(
      width: 46,
      child: Opacity(
        opacity: (permissions?.assets.canDownloadSource ?? false) ? 1.0 : 0.4,
        child: IconButton(
          onPressed: (permissions?.assets.canDownloadSource ?? false)
              ? () {
                  final img = model.images.firstWhereOrNull(
                    (_) => _.type == AssetImageTypeEnum.source,
                  );

                  if (img == null) {
                    return;
                  }

                  final apiBaseUrl = GetIt.instance<Config>().apiBaseUrl;

                  final url =
                      '$apiBaseUrl/asset/${model.id}/image/${img.id}/download';

                  if (kIsWeb) {
                    html.window.open(url, '_blank');
                  }
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
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
          icon: Icon(
            MdiIcons.trayArrowDown,
            color: const Color(0xAEFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return SizedBox(
      width: 46,
      child: Opacity(
        opacity: (permissions?.assets.canModify ?? false) ? 1.0 : 0.4,
        child: IconButton(
          onPressed: (permissions?.assets.canModify ?? false) ? onEdit : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
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
          icon: Icon(
            MdiIcons.textBoxEditOutline,
            color: const Color(0xAEFFFFFF),
          ),
        ),
      ),
    );
  }
}
