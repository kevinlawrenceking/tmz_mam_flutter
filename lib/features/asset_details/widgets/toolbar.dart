import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/features/user_collections/widgets/add_assets_to_collection_modal.dart';
import 'package:tmz_damz/shared/widgets/change_notifier_listener.dart';
import 'package:tmz_damz/shared/widgets/confirmation_prompt.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/config.dart';
import 'package:tmz_damz/utils/route_change_notifier.dart';
import 'package:web/web.dart' as web;

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
    return Container(
      height: 54,
      clipBehavior: Clip.antiAlias,
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
            _buildCopyLinkButton(),
            const SizedBox(width: 10.0),
            _buildAddToCollectionButton(
              context: context,
            ),
            const SizedBox(width: 10.0),
            _buildDownloadButton(),
            const SizedBox(width: 10.0),
            _buildOpenInNew(),
            const Spacer(),
            _buildEditButton(),
            const SizedBox(width: 10.0),
            _buildDeleteButton(
              context: context,
            ),
          ],
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
              ? () async {
                  final theme = Theme.of(context);

                  final notifier = Provider.of<RouteChangeNotifier>(
                    context,
                    listen: false,
                  );

                  await showDialog<void>(
                    context: context,
                    barrierColor: Colors.black54,
                    barrierDismissible: false,
                    builder: (_) {
                      return ChangeNotifierListener(
                        notifier: notifier,
                        listener: () {
                          Navigator.of(context).pop();
                        },
                        child: OverflowBox(
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
                        ),
                      );
                    },
                  );
                }
              : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
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
          AutoRouter.of(context).navigate(AssetsSearchRoute());
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
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

  Widget _buildCopyLinkButton() {
    return SizedBox(
      width: 46,
      child: IconButton(
        onPressed: () async {
          final url = '${web.window.location.origin}/#/asset/${model.id}';

          await Clipboard.setData(
            ClipboardData(
              text: url,
            ),
          );

          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message:
                // ignore: lines_longer_than_80_chars
                'Asset link copied to clipboard!',
          );
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
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
        icon: Icon(
          MdiIcons.link,
          color: const Color(0xAEFFFFFF),
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
            backgroundColor: WidgetStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
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
                    web.window.open(url, '_blank');
                  }
                }
              : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
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
            backgroundColor: WidgetStateProperty.all(
              const Color(0x30FFFFFF),
            ),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
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
          icon: Icon(
            MdiIcons.textBoxEditOutline,
            color: const Color(0xAEFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _buildOpenInNew() {
    return SizedBox(
      width: 46,
      child: IconButton(
        onPressed: () async {
          final url = '${web.window.location.origin}/#/asset/${model.id}';

          if (kIsWeb) {
            web.window.open(url, '_blank');
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
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
        icon: Icon(
          MdiIcons.openInNew,
          color: const Color(0xAEFFFFFF),
        ),
      ),
    );
  }
}
