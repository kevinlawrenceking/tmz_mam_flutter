import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/models/send_to.dart';
import 'package:tmz_damz/features/assets/widgets/asset_list_item.dart';
import 'package:tmz_damz/features/assets/widgets/asset_tile_item.dart';
import 'package:tmz_damz/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_damz/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/config.dart';
import 'package:web/web.dart' as web;

class AssetDataView extends StatefulWidget {
  final ScrollController scrollController;
  final AccessControlPermissionMapModel? permissions;
  final List<SendToModel>? sendToOptions;
  final CollectionModel? collection;
  final List<AssetDetailsModel> assets;
  final List<String> selectedIDs;
  final LayoutModeEnum layoutMode;
  final ThumbnailSizeEnum thumbnailSize;
  final void Function(AssetDetailsModel model) onTap;
  final void Function(AssetDetailsModel model) onDoubleTap;
  final void Function(List<String> selectedIDs) onSelectionChanged;
  final void Function(List<String> selectedIDs) onBulkUpdate;
  final void Function(List<String> selectedIDs, String sendToID) onSendTo;
  final void Function(List<String> selectedIDs) onAddSelectedToCollection;
  final void Function(List<String> selectedIDs) onMoveSelectedToCollection;
  final void Function(List<String> selectedIDs) onDeleteSelected;
  final void Function(List<String> selectedIDs) onRemoveSelectedFromCollection;
  final VoidCallback onReload;

  const AssetDataView({
    super.key,
    required this.scrollController,
    required this.permissions,
    required this.sendToOptions,
    required this.collection,
    required this.assets,
    required this.selectedIDs,
    required this.layoutMode,
    required this.thumbnailSize,
    required this.onTap,
    required this.onDoubleTap,
    required this.onSelectionChanged,
    required this.onBulkUpdate,
    required this.onSendTo,
    required this.onAddSelectedToCollection,
    required this.onMoveSelectedToCollection,
    required this.onDeleteSelected,
    required this.onRemoveSelectedFromCollection,
    required this.onReload,
  });

  @override
  State<AssetDataView> createState() => _AssetDataViewState();
}

class _AssetDataViewState extends State<AssetDataView> {
  late final FocusNode _focusNode;

  int? _selectionStart;
  int? _selectionEnd;

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) {
        if ((event is! KeyDownEvent) ||
            (FocusManager.instance.primaryFocus != node)) {
          return KeyEventResult.ignored;
        }

        if ((event.logicalKey == LogicalKeyboardKey.delete) ||
            (event.physicalKey == PhysicalKeyboardKey.delete)) {
          if (widget.selectedIDs.isNotEmpty) {
            if (widget.collection != null) {
              final canRemoveCollectionAssets = (() {
                if (widget.collection?.ownedBy.userID ==
                    widget.permissions?.userID) {
                  return true;
                } else if (widget.permissions?.collections.canRemoveAssets ??
                    false) {
                  return true;
                }

                return false;
              })();

              if (canRemoveCollectionAssets) {
                widget.onRemoveSelectedFromCollection(widget.selectedIDs);
              } else {
                Toast.showNotification(
                  showDuration: const Duration(seconds: 5),
                  type: ToastTypeEnum.warning,
                  message:
                      // ignore: lines_longer_than_80_chars
                      'You do not have permission to remove assets\nfrom collections you do not own.',
                );
              }
            } else {
              final canDelete = (() {
                if ((widget.permissions?.assets.canDelete ?? false) &&
                    (widget.selectedIDs.length == 1)) {
                  return true;
                } else if ((widget.permissions?.assets.canDeleteMultiple ??
                        false) &&
                    (widget.selectedIDs.length > 1)) {
                  return true;
                }

                return false;
              })();

              if (canDelete) {
                widget.onDeleteSelected(widget.selectedIDs);
              } else {
                final multiple =
                    (widget.permissions?.assets.canDelete ?? false) &&
                        (widget.selectedIDs.length > 1);

                Toast.showNotification(
                  showDuration: const Duration(seconds: 5),
                  type: ToastTypeEnum.warning,
                  message:
                      // ignore: lines_longer_than_80_chars
                      'You do not have permission to delete${multiple ? ' multiple' : ''} assets.',
                );
              }
            }
          }

          return KeyEventResult.handled;
        } else if ((event.logicalKey == LogicalKeyboardKey.f5) ||
            (event.physicalKey == PhysicalKeyboardKey.f5)) {
          widget.onReload();

          return KeyEventResult.handled;
        } else if ((HardwareKeyboard.instance.isControlPressed ||
                HardwareKeyboard.instance.isMetaPressed) &&
            ((event.logicalKey == LogicalKeyboardKey.keyA) ||
                (event.physicalKey == PhysicalKeyboardKey.keyA))) {
          _selectAll();

          return KeyEventResult.handled;
        } else if ((HardwareKeyboard.instance.isControlPressed ||
                HardwareKeyboard.instance.isMetaPressed) &&
            ((event.logicalKey == LogicalKeyboardKey.keyD) ||
                (event.physicalKey == PhysicalKeyboardKey.keyD))) {
          _deselectAll();

          return KeyEventResult.handled;
        } else if ((HardwareKeyboard.instance.isControlPressed ||
                HardwareKeyboard.instance.isMetaPressed) &&
            ((event.logicalKey == LogicalKeyboardKey.keyR) ||
                (event.physicalKey == PhysicalKeyboardKey.keyR))) {
          widget.onReload();

          return KeyEventResult.handled;
        } else {
          return KeyEventResult.ignored;
        }
      },
      focusNode: _focusNode,
      child: GestureDetector(
        onLongPressDown: (_) {
          _focusNode.requestFocus();
        },
        child: widget.layoutMode == LayoutModeEnum.list
            ? _buildListView()
            : _buildTileView(),
      ),
    );
  }

  Widget _buildContextMenu({
    required AssetDetailsModel model,
    required Widget child,
  }) {
    final canDelete = (() {
      if ((widget.permissions?.assets.canDelete ?? false) &&
          (widget.selectedIDs.length == 1)) {
        return true;
      } else if ((widget.permissions?.assets.canDeleteMultiple ?? false) &&
          (widget.selectedIDs.length > 1)) {
        return true;
      }

      return false;
    })();

    final canAddCollectionAssets = (() {
      if (widget.selectedIDs.isEmpty) {
        return false;
      }

      if (widget.permissions?.collections.canAddAssets ?? false) {
        return true;
      }

      return false;
    })();

    final canRemoveCollectionAssets = (() {
      if (widget.selectedIDs.isEmpty) {
        return false;
      }

      if (widget.collection?.ownedBy.userID == widget.permissions?.userID) {
        return true;
      } else if (widget.permissions?.collections.canRemoveAssets ?? false) {
        return true;
      }

      return false;
    })();

    return ContextMenuRegion(
      contextMenu: GenericContextMenu(
        buttonConfigs: [
          if (widget.selectedIDs.isNotEmpty) ...[
            ContextMenuButtonConfig(
              // ignore: lines_longer_than_80_chars
              'Copy shareable link${widget.selectedIDs.length > 1 ? 's' : ''}',
              icon: Icon(
                MdiIcons.link,
                size: 16.0,
              ),
              onPressed: () async {
                final links = widget.selectedIDs
                    .map(
                      (id) => '${web.window.location.origin}/#/asset/$id',
                    )
                    .toList();

                await Clipboard.setData(
                  ClipboardData(
                    text: links.join('\n'),
                  ),
                );

                Toast.showNotification(
                  showDuration: const Duration(seconds: 3),
                  type: ToastTypeEnum.success,
                  message:
                      // ignore: lines_longer_than_80_chars
                      'Asset link${widget.selectedIDs.length > 1 ? 's' : ''} copied to clipboard!',
                );
              },
            ),
            null, // divider
            ContextMenuButtonConfig(
              'View details...',
              icon: Icon(
                MdiIcons.imageEditOutline,
                size: 16.0,
              ),
              onPressed:
                  ((widget.permissions?.assets.canViewDetails ?? false) &&
                          (widget.selectedIDs.length == 1))
                      ? () {
                          AutoRouter.of(context).navigate(
                            AssetDetailsRoute(
                              assetID: model.id,
                            ),
                          );
                        }
                      : null,
            ),
            ContextMenuButtonConfig(
              'Bulk update...',
              icon: Icon(
                MdiIcons.textBoxEditOutline,
                size: 16.0,
              ),
              onPressed: ((widget.permissions?.assets.canBulkUpdate ?? false) &&
                      widget.selectedIDs.isNotEmpty)
                  ? () => widget.onBulkUpdate(widget.selectedIDs)
                  : null,
            ),
            null, // divider
            ContextMenuButtonConfig(
              // ignore: lines_longer_than_80_chars
              'Download source image${widget.selectedIDs.length > 1 ? 's' : ''}...',
              icon: Icon(
                MdiIcons.trayArrowDown,
                size: 16.0,
              ),
              onPressed: (widget.permissions?.assets.canDownloadSource ?? false)
                  ? _downloadSourceImages
                  : null,
            ),
            null, // divider
            if (widget.sendToOptions?.isNotEmpty ?? false) ...[
              ...List.generate(
                widget.sendToOptions!.length,
                (index) {
                  final option = widget.sendToOptions![index];
                  return ContextMenuButtonConfig(
                    option.label,
                    icon: Icon(
                      MdiIcons.progressUpload,
                      size: 16.0,
                    ),
                    onPressed:
                        ((widget.permissions?.assets.canSendTo ?? false) &&
                                widget.selectedIDs.isNotEmpty)
                            ? () => widget.onSendTo(
                                  widget.selectedIDs,
                                  option.id,
                                )
                            : null,
                  );
                },
              ),
              null,
            ],
            ContextMenuButtonConfig(
              // ignore: lines_longer_than_80_chars
              'Add selected asset${widget.selectedIDs.length > 1 ? 's' : ''} to collection...',
              icon: Icon(
                MdiIcons.folderPlusOutline,
                size: 16.0,
              ),
              onPressed: canAddCollectionAssets
                  ? () => widget.onAddSelectedToCollection(widget.selectedIDs)
                  : null,
            ),
            if (widget.collection == null) null, // divider
            if (widget.collection != null) ...[
              ContextMenuButtonConfig(
                // ignore: lines_longer_than_80_chars
                'Move selected asset${widget.selectedIDs.length > 1 ? 's' : ''} to collection...',
                icon: Icon(
                  MdiIcons.arrowLeftBold,
                  size: 16.0,
                ),
                onPressed: canAddCollectionAssets && canRemoveCollectionAssets
                    ? () => widget.onMoveSelectedToCollection(
                          widget.selectedIDs,
                        )
                    : null,
              ),
              ContextMenuButtonConfig(
                // ignore: lines_longer_than_80_chars
                'Remove selected asset${widget.selectedIDs.length > 1 ? 's' : ''} from collection',
                shortcutLabel: 'Del',
                icon: Icon(
                  MdiIcons.closeThick,
                  size: 16.0,
                ),
                onPressed: canRemoveCollectionAssets
                    ? () => widget.onRemoveSelectedFromCollection(
                          widget.selectedIDs,
                        )
                    : null,
              ),
              null, // divider
            ],
            ContextMenuButtonConfig(
              // ignore: lines_longer_than_80_chars
              'Delete selected asset${widget.selectedIDs.length > 1 ? 's' : ''}',
              shortcutLabel: (widget.collection == null) ? 'Del' : null,
              icon: Icon(
                MdiIcons.closeThick,
                size: 16.0,
              ),
              onPressed: canDelete
                  ? () => widget.onDeleteSelected(
                        widget.selectedIDs,
                      )
                  : null,
            ),
            null, // divider
          ],
          ContextMenuButtonConfig(
            'Select All',
            shortcutLabel: 'Ctrl+A, Cmd+A',
            icon: Icon(
              MdiIcons.selectAll,
              size: 18.0,
            ),
            onPressed: () => _selectAll(),
          ),
          ContextMenuButtonConfig(
            'Deselect All',
            shortcutLabel: 'Ctrl+D, Cmd+D',
            icon: Icon(
              MdiIcons.selectRemove,
              size: 18.0,
            ),
            onPressed:
                widget.selectedIDs.isNotEmpty ? () => _deselectAll() : null,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required int index,
    required double height,
    required AssetDetailsModel model,
  }) {
    return GestureDetector(
      onDoubleTap: () => widget.onDoubleTap(model),
      onLongPressDown: (_) {
        _onItemLongPressDown(
          index: index,
          model: model,
        );
      },
      onSecondaryLongPressDown: (_) {
        _onItemSecondaryLongPressDown(
          index: index,
          model: model,
        );
      },
      child: SizedBox(
        height: height,
        child: AssetListItem(
          apiBaseUrl: Config.instance.service.apiBaseUrl,
          scrollController: widget.scrollController,
          model: model,
          selected: widget.selectedIDs.any((id) => id == model.id),
        ),
      ),
    );
  }

  Widget _buildListView() {
    const itemHeight = 80.0;

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.assets.length,
      itemBuilder: (context, index) {
        return _buildListItem(
          context: context,
          index: index,
          height: itemHeight,
          model: widget.assets[index],
        );
      },
    );
  }

  Widget _buildTileItem({
    required BuildContext context,
    required int index,
    required double margin,
    required double width,
    required AssetDetailsModel model,
  }) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.all(margin),
        child: GestureDetector(
          onDoubleTap: () => widget.onDoubleTap(model),
          onLongPressDown: (_) {
            _onItemLongPressDown(
              index: index,
              model: model,
            );
          },
          onSecondaryLongPressDown: (_) {
            _onItemSecondaryLongPressDown(
              index: index,
              model: model,
            );
          },
          child: _buildContextMenu(
            model: model,
            child: AssetTileItem(
              apiBaseUrl: Config.instance.service.apiBaseUrl,
              scrollController: widget.scrollController,
              model: model,
              selected: widget.selectedIDs.any((id) => id == model.id),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileView() {
    const itemMargin = 10.0;

    double maxItemWidth;

    switch (widget.thumbnailSize) {
      case ThumbnailSizeEnum.small:
        maxItemWidth = 230.0;
        break;
      case ThumbnailSizeEnum.medium:
        maxItemWidth = 350.0;
        break;
      case ThumbnailSizeEnum.large:
        maxItemWidth = 650.0;
        break;
    }

    return MaskedScrollView(
      controller: widget.scrollController,
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - (itemMargin * 2) - 2;
          final columns = (width / maxItemWidth).ceil();

          double itemWidth;
          if (columns <= widget.assets.length) {
            itemWidth = width / columns;
          } else {
            itemWidth = maxItemWidth;
          }

          return Padding(
            padding: const EdgeInsets.all(itemMargin),
            child: Wrap(
              children: widget.assets.indexed.map((_) {
                return _buildTileItem(
                  context: context,
                  index: _.$1,
                  margin: itemMargin,
                  width: itemWidth,
                  model: _.$2,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  void _onItemLongPressDown({
    required int index,
    required AssetDetailsModel model,
  }) {
    final selectedIDs = <String>[];

    selectedIDs.addAll(widget.selectedIDs);

    if (!HardwareKeyboard.instance.isShiftPressed) {
      _selectionStart = index != -1 ? index : null;

      if (!selectedIDs.any((id) => id == model.id)) {
        if (!HardwareKeyboard.instance.isControlPressed &&
            !HardwareKeyboard.instance.isMetaPressed) {
          selectedIDs.clear();
        }
        selectedIDs.add(model.id);
      } else {
        if (HardwareKeyboard.instance.isControlPressed ||
            HardwareKeyboard.instance.isMetaPressed) {
          selectedIDs.removeWhere((id) => id == model.id);
        } else {
          selectedIDs.removeWhere((id) => id != model.id);
        }
      }
    } else {
      _selectionEnd = index != -1 ? index : null;

      if ((_selectionStart != null) && (_selectionEnd != null)) {
        if (_selectionStart! < _selectionEnd!) {
          selectedIDs.addAll(
            widget.assets
                .getRange(_selectionStart!, _selectionEnd! + 1)
                .where((_) => !selectedIDs.any((id) => id == _.id))
                .map((_) => _.id),
          );
        } else if (_selectionEnd! < _selectionStart!) {
          selectedIDs.addAll(
            widget.assets
                .getRange(_selectionEnd!, _selectionStart!)
                .where((_) => !selectedIDs.any((id) => id == _.id))
                .map((_) => _.id),
          );
        }
      }
    }

    if (mounted) {
      setState(() {});
    }

    if (!HardwareKeyboard.instance.isControlPressed &&
        !HardwareKeyboard.instance.isMetaPressed &&
        !HardwareKeyboard.instance.isShiftPressed) {
      widget.onTap(model);
    }

    widget.onSelectionChanged(selectedIDs);
  }

  void _onItemSecondaryLongPressDown({
    required int index,
    required AssetDetailsModel model,
  }) {
    final selectedIDs = <String>[];

    selectedIDs.addAll(widget.selectedIDs);

    if (!HardwareKeyboard.instance.isShiftPressed) {
      _selectionStart = index != -1 ? index : null;

      if (!selectedIDs.any((id) => id == model.id)) {
        if (!HardwareKeyboard.instance.isControlPressed &&
            !HardwareKeyboard.instance.isMetaPressed) {
          selectedIDs.clear();
        }

        selectedIDs.add(model.id);
      }
    } else {
      _selectionEnd = index != -1 ? index : null;

      if ((_selectionStart != null) && (_selectionEnd != null)) {
        if (_selectionStart! < _selectionEnd!) {
          selectedIDs.addAll(
            widget.assets
                .getRange(_selectionStart!, _selectionEnd! + 1)
                .where((_) => !selectedIDs.any((id) => id == _.id))
                .map((_) => _.id),
          );
        } else if (_selectionEnd! < _selectionStart!) {
          selectedIDs.addAll(
            widget.assets
                .getRange(_selectionEnd!, _selectionStart!)
                .where((_) => !selectedIDs.any((id) => id == _.id))
                .map((_) => _.id),
          );
        }
      }
    }

    if (mounted) {
      setState(() {});
    }

    if (!HardwareKeyboard.instance.isControlPressed &&
        !HardwareKeyboard.instance.isMetaPressed &&
        !HardwareKeyboard.instance.isShiftPressed) {
      widget.onTap(model);
    }

    widget.onSelectionChanged(selectedIDs);
  }

  void _deselectAll() {
    widget.onSelectionChanged([]);
  }

  void _selectAll() {
    widget.onSelectionChanged(widget.assets.map((_) => _.id).toList());
  }

  Future<void> _downloadSourceImages() async {
    if (widget.selectedIDs.isEmpty) {
      Toast.showNotification(
        showDuration: const Duration(seconds: 3),
        type: ToastTypeEnum.information,
        message: 'No assets selected!',
      );
      return;
    }

    final selected = widget.assets
        .where((asset) => widget.selectedIDs.contains(asset.id))
        .toList();

    for (var i = 0; i < selected.length; i++) {
      final asset = selected[i];

      final img = asset.images.firstWhereOrNull(
        (_) => _.type == AssetImageTypeEnum.source,
      );

      if (img == null) {
        return;
      }

      final url =
          '${Config.instance.service.apiBaseUrl}/asset/${asset.id}/image/${img.id}/download';

      if (kIsWeb) {
        web.window.open(url, '_blank');
      }

      await Future<void>.delayed(
        const Duration(
          milliseconds: 50,
        ),
      );
    }
  }
}
