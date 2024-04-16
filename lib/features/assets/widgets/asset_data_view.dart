import 'package:auto_route/auto_route.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/features/assets/widgets/asset_list_item.dart';
import 'package:tmz_damz/features/assets/widgets/asset_tile_item.dart';
import 'package:tmz_damz/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_damz/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_damz/shared/bloc/global_bloc.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/config.dart';

class AssetDataView extends StatefulWidget {
  final ScrollController scrollController;
  final Config config;
  final List<AssetDetailsModel> assets;
  final List<String> selectedIDs;
  final LayoutModeEnum layoutMode;
  final ThumbnailSizeEnum thumbnailSize;
  final bool enableRemoveFromCollection;
  final void Function(AssetDetailsModel model) onTap;
  final void Function(AssetDetailsModel model) onDoubleTap;
  final void Function(List<String> selectedIDs) onSelectionChanged;
  final void Function(List<String> selectedIDs) onAddSelectedToCollection;
  final void Function(List<String> selectedIDs) onRemoveSelected;
  final VoidCallback onReload;

  const AssetDataView({
    super.key,
    required this.scrollController,
    required this.config,
    required this.assets,
    required this.selectedIDs,
    required this.layoutMode,
    required this.thumbnailSize,
    required this.enableRemoveFromCollection,
    required this.onTap,
    required this.onDoubleTap,
    required this.onSelectionChanged,
    required this.onAddSelectedToCollection,
    required this.onRemoveSelected,
    required this.onReload,
  });

  @override
  State<AssetDataView> createState() => _AssetDataViewState();
}

class _AssetDataViewState extends State<AssetDataView> {
  late final FocusNode _focusNode;

  final _selectedIDs = <String>[];
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

    _selectedIDs.addAll(widget.selectedIDs);
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
          if (_selectedIDs.isNotEmpty) {
            widget.onRemoveSelected(_selectedIDs);
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
    final auth = GetIt.instance<IAuthDataSource>();

    return FutureBuilder(
      future: auth.getPermissions(),
      builder: (context, snapshot) {
        final permissions = snapshot.data?.fold(
          (failure) => null,
          (permissions) => permissions,
        );

        return ContextMenuRegion(
          enableLongPress: false,
          contextMenu: GenericContextMenu(
            buttonConfigs: [
              if (_selectedIDs.isNotEmpty) ...[
                ContextMenuButtonConfig(
                  'Copy Technical ID${_selectedIDs.length > 1 ? 's' : ''}',
                  icon: Icon(
                    MdiIcons.contentCopy,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: _selectedIDs.join(', '),
                      ),
                    );

                    Toast.showNotification(
                      type: ToastTypeEnum.success,
                      message:
                          'Technical ID${_selectedIDs.length > 1 ? 's' : ''} copied to clipboard!',
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
                  onPressed: ((permissions?.assets.canViewDetails ?? false) &&
                          (_selectedIDs.length == 1))
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
                  onPressed: (permissions?.assets.canBulkUpdate ?? false)
                      ? () {
                          //
                        }
                      : null,
                ),
                null, // divider
                ContextMenuButtonConfig(
                  'Download source image${_selectedIDs.length > 1 ? 's' : ''}...',
                  icon: Icon(
                    MdiIcons.trayArrowDown,
                    size: 16.0,
                  ),
                  onPressed: (permissions?.assets.canDownloadSource ?? false)
                      ? () {
                          BlocProvider.of<GlobalBloc>(context).add(
                            DownloadSelectedAssetsEvent(),
                          );
                        }
                      : null,
                ),
                null, // divider
                if (permissions?.collections.canAddAssets ?? false)
                  ContextMenuButtonConfig(
                    'Add selected asset${_selectedIDs.length > 1 ? 's' : ''} to collection...',
                    icon: Icon(
                      MdiIcons.folderPlusOutline,
                      size: 16.0,
                    ),
                    onPressed: () =>
                        widget.onAddSelectedToCollection(_selectedIDs),
                  ),
                if ((permissions?.collections.canRemoveAssets ?? false) &&
                    widget.enableRemoveFromCollection)
                  ContextMenuButtonConfig(
                    'Remove selected asset${_selectedIDs.length > 1 ? 's' : ''} from collection',
                    shortcutLabel: 'Del',
                    icon: Icon(
                      MdiIcons.closeThick,
                      size: 16.0,
                    ),
                    onPressed: () => widget.onRemoveSelected(_selectedIDs),
                  ),
                if ((permissions?.collections.canAddAssets ?? false) ||
                    (permissions?.collections.canRemoveAssets ?? false))
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
                    _selectedIDs.isNotEmpty ? () => _deselectAll() : null,
              ),
            ],
          ),
          child: child,
        );
      },
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
          apiBaseUrl: widget.config.apiBaseUrl,
          scrollController: widget.scrollController,
          model: model,
          selected: _selectedIDs.any((id) => id == model.id),
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
              apiBaseUrl: widget.config.apiBaseUrl,
              scrollController: widget.scrollController,
              model: model,
              selected: _selectedIDs.any((id) => id == model.id),
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
    if (!HardwareKeyboard.instance.isShiftPressed) {
      _selectionStart = index != -1 ? index : null;

      if (!_selectedIDs.any((id) => id == model.id)) {
        if (!HardwareKeyboard.instance.isControlPressed &&
            !HardwareKeyboard.instance.isMetaPressed) {
          _selectedIDs.clear();
        }
        _selectedIDs.add(model.id);
      } else {
        if (HardwareKeyboard.instance.isControlPressed ||
            HardwareKeyboard.instance.isMetaPressed) {
          _selectedIDs.removeWhere((id) => id == model.id);
        } else {
          _selectedIDs.removeWhere((id) => id != model.id);
        }
      }
    } else {
      _selectionEnd = index != -1 ? index : null;

      if ((_selectionStart != null) && (_selectionEnd != null)) {
        if (_selectionStart! < _selectionEnd!) {
          final selectedIDs = widget.assets
              .getRange(_selectionStart!, _selectionEnd! + 1)
              .where((_) => !_selectedIDs.any((id) => id == _.id))
              .map((_) => _.id);

          _selectedIDs.addAll(selectedIDs);
        } else if (_selectionEnd! < _selectionStart!) {
          final selectedIDs = widget.assets
              .getRange(_selectionEnd!, _selectionStart!)
              .where((_) => !_selectedIDs.any((id) => id == _.id))
              .map((_) => _.id);

          _selectedIDs.addAll(selectedIDs);
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

    widget.onSelectionChanged(_selectedIDs);
  }

  void _onItemSecondaryLongPressDown({
    required int index,
    required AssetDetailsModel model,
  }) {
    if (!HardwareKeyboard.instance.isShiftPressed) {
      _selectionStart = index != -1 ? index : null;

      if (!_selectedIDs.any((id) => id == model.id)) {
        if (!HardwareKeyboard.instance.isControlPressed &&
            !HardwareKeyboard.instance.isMetaPressed) {
          _selectedIDs.clear();
        }

        _selectedIDs.add(model.id);
      }
    } else {
      _selectionEnd = index != -1 ? index : null;

      if ((_selectionStart != null) && (_selectionEnd != null)) {
        if (_selectionStart! < _selectionEnd!) {
          final selectedIDs = widget.assets
              .getRange(_selectionStart!, _selectionEnd! + 1)
              .where((_) => !_selectedIDs.any((id) => id == _.id))
              .map((_) => _.id);

          _selectedIDs.addAll(selectedIDs);
        } else if (_selectionEnd! < _selectionStart!) {
          final selectedIDs = widget.assets
              .getRange(_selectionEnd!, _selectionStart!)
              .where((_) => !_selectedIDs.any((id) => id == _.id))
              .map((_) => _.id);

          _selectedIDs.addAll(selectedIDs);
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

    widget.onSelectionChanged(_selectedIDs);
  }

  void _deselectAll() {
    setState(() {
      _selectedIDs.clear();
    });
  }

  void _selectAll() {
    setState(() {
      _selectedIDs.clear();
      _selectedIDs.addAll(widget.assets.map((_) => _.id));
    });
  }
}
