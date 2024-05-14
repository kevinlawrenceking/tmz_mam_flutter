import 'package:collection/collection.dart';
import 'package:context_menus/context_menus.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/features/collections/bloc/bloc.dart';
import 'package:tmz_damz/features/collections/widgets/edit_collection_modal.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/scroll_aware_builder.dart';
import 'package:tmz_damz/utils/config.dart';

class CollectionDataView extends StatefulWidget {
  final ScrollController scrollController;
  final Config config;
  final List<CollectionModel> collections;
  final List<String> selectedIDs;
  final void Function(List<String> selectedIDs) onSelectionChanged;
  final void Function(List<String> selectedIDs) onAddSelectedToFavorites;
  final void Function(List<String> selectedIDs) onDeleteSelected;
  final void Function(List<String> selectedIDs) onRemoveSelectedFromFavorites;
  final VoidCallback onReload;

  const CollectionDataView({
    super.key,
    required this.scrollController,
    required this.config,
    required this.collections,
    required this.selectedIDs,
    required this.onSelectionChanged,
    required this.onAddSelectedToFavorites,
    required this.onDeleteSelected,
    required this.onRemoveSelectedFromFavorites,
    required this.onReload,
  });

  @override
  State<CollectionDataView> createState() => _CollectionDataViewState();
}

class _CollectionDataViewState extends State<CollectionDataView> {
  static const kTableHeaderTextStyle = TextStyle(
    color: Color(0xFF909295),
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  late final FocusNode _focusNode;

  int? _selectionStart;
  int? _selectionEnd;
  bool? _lastSelectionState;

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
    final theme = Theme.of(context);

    return Focus(
      onKeyEvent: (node, event) {
        if ((event is! KeyDownEvent) ||
            (FocusManager.instance.primaryFocus != node)) {
          return KeyEventResult.ignored;
        }

        if ((event.logicalKey == LogicalKeyboardKey.delete) ||
            (event.physicalKey == PhysicalKeyboardKey.delete)) {
          if (widget.selectedIDs.isNotEmpty) {
            widget.onDeleteSelected(widget.selectedIDs);
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
        child: Theme(
          data: theme.copyWith(
            dividerTheme: theme.dividerTheme.copyWith(
              color: const Color(0xFF3D3D3D),
            ),
          ),
          child: _buildDataTable(
            theme: theme,
          ),
        ),
      ),
    );
  }

  Widget _buildContextMenu(BuildContext context) {
    final auth = GetIt.instance<IAuthDataSource>();

    return FutureBuilder(
      future: auth.getPermissions(),
      builder: (_, snapshot) {
        final permissions = snapshot.data?.fold(
          (failure) => null,
          (permissions) => permissions,
        );

        final favorites = widget.collections
            .where((_) => _.favorited)
            .map((_) => _.id)
            .toList();

        return GenericContextMenu(
          buttonConfigs: [
            if (permissions?.collections.canModify ?? false) ...[
              ContextMenuButtonConfig(
                // ignore: lines_longer_than_80_chars
                'Edit collection...',
                icon: Icon(
                  MdiIcons.pencil,
                  size: 16.0,
                ),
                onPressed: (widget.selectedIDs.length == 1)
                    ? () {
                        final model = widget.collections.firstWhereOrNull(
                          (_) => _.id == widget.selectedIDs[0],
                        );

                        if (model == null) {
                          return;
                        }

                        _showEditCollectionDialog(
                          context: context,
                          model: model,
                        );
                      }
                    : null,
              ),
              null, // divider
            ],
            if ((permissions?.collections.canDelete ?? false) ||
                (permissions?.collections.canDeleteMultiple ?? false)) ...[
              ContextMenuButtonConfig(
                // ignore: lines_longer_than_80_chars
                'Delete selected collection${widget.selectedIDs.length > 1 ? 's' : ''}',
                shortcutLabel: 'Del',
                icon: Icon(
                  MdiIcons.closeThick,
                  size: 16.0,
                ),
                onPressed: ((widget.selectedIDs.length == 1) ||
                        (permissions?.collections.canDeleteMultiple ?? false))
                    ? () => widget.onDeleteSelected(
                          widget.selectedIDs,
                        )
                    : null,
              ),
              null, // divider
            ],
            if (widget.selectedIDs.isNotEmpty &&
                widget.selectedIDs.any((_) => !favorites.contains(_)))
              ContextMenuButtonConfig(
                // ignore: lines_longer_than_80_chars
                'Add selected collection${widget.selectedIDs.length > 1 ? 's' : ''} to favorites',
                icon: Icon(
                  MdiIcons.starPlus,
                  size: 16.0,
                ),
                onPressed: () => widget.onAddSelectedToFavorites(
                  widget.selectedIDs,
                ),
              ),
            if (widget.selectedIDs.isNotEmpty &&
                widget.selectedIDs.any((_) => favorites.contains(_)))
              ContextMenuButtonConfig(
                // ignore: lines_longer_than_80_chars
                'Remove selected collection${widget.selectedIDs.length > 1 ? 's' : ''} from favorites',
                icon: Icon(
                  MdiIcons.starMinus,
                  size: 16.0,
                ),
                onPressed: () => widget.onRemoveSelectedFromFavorites(
                  widget.selectedIDs,
                ),
              ),
            null, // divider
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
        );
      },
    );
  }

  Widget _buildDataTable({
    required ThemeData theme,
  }) {
    const rowHeight = 80.0;

    return DataTable2(
      scrollController: widget.scrollController,
      columnSpacing: 20.0,
      headingRowHeight: 50.0,
      horizontalMargin: 10.0,
      dataRowHeight: rowHeight,
      showBottomBorder: true,
      showCheckboxColumn: false,
      smRatio: 0.5,
      lmRatio: 1.5,
      headingCheckboxTheme: theme.checkboxTheme,
      datarowCheckboxTheme: theme.checkboxTheme,
      columns: [
        DataColumn2(
          fixedWidth: (rowHeight - 10.0) * (16.0 / 9.0),
          label: Container(
            constraints: const BoxConstraints.expand(),
          ),
        ),
        DataColumn2(
          size: ColumnSize.L,
          label: Container(
            constraints: const BoxConstraints.expand(),
          ),
        ),
        DataColumn2(
          fixedWidth: 40.0,
          label: Container(
            constraints: const BoxConstraints.expand(),
          ),
        ),
        DataColumn2(
          fixedWidth: 40.0,
          label: Container(
            constraints: const BoxConstraints.expand(),
          ),
        ),
        DataColumn2(
          fixedWidth: 100.0,
          label: Container(
            constraints: const BoxConstraints.expand(),
            child: const Center(
              child: Text(
                'ASSETS',
                style: kTableHeaderTextStyle,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 200.0,
          label: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'OWNER',
                style: kTableHeaderTextStyle,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 200.0,
          label: Container(
            constraints: const BoxConstraints.expand(),
            child: const Center(
              child: Text(
                'CREATED',
                style: kTableHeaderTextStyle,
              ),
            ),
          ),
        ),
      ],
      rows: List.generate(
        widget.collections.length,
        (index) => _buildItemRow(
          context: context,
          theme: theme,
          index: index,
          model: widget.collections[index],
        ),
      ),
      onSelectAll: (value) {
        widget.onSelectionChanged(
          (value ?? false) ? widget.collections.map((_) => _.id).toList() : [],
        );
      },
    );
  }

  DataRow _buildItemRow({
    required BuildContext context,
    required ThemeData theme,
    required int index,
    required CollectionModel model,
  }) {
    final selected = widget.selectedIDs.any((id) => id == model.id);

    return DataRow2.byIndex(
      index: index,
      color: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return index.isEven
              ? Colors.white.withAlpha(40)
              : Colors.white.withAlpha(30);
        } else {
          return index.isEven
              ? Colors.white.withAlpha(10)
              : Colors.white.withAlpha(20);
        }
      }),
      decoration: selected
          ? const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0x9F7B3232),
                ),
                bottom: BorderSide(
                  color: Color(0x9F301B1B),
                ),
              ),
              color: Color(0x9F792A2A),
            )
          : null,
      selected: selected,
      onSecondaryTap: () => _onDataRowSecondaryTap(
        context: context,
        index: index,
        collectionID: model.id,
      ),
      onSelectChanged: (value) => _onDataRowSelectChanged(
        index: index,
        collectionID: model.id,
        selected: value,
      ),
      cells: [
        DataCell(
          Container(
            constraints: const BoxConstraints.expand(),
            child: Container(
              color: Colors.black,
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: ScrollAwareBuilder(
                controller: widget.scrollController,
                builder: (context) => FileThumbnail(
                  url:
                      '${widget.config.apiBaseUrl}/collection/${model.id}/thumbnail',
                  errorWidget: Center(
                    child: Icon(
                      MdiIcons.imageMultiple,
                      color: const Color(0xFF303030),
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Row(
              children: [
                model.favorited
                    ? Icon(
                        MdiIcons.star,
                        color: const Color(0xFFFFA600),
                        shadows: kElevationToShadow[1],
                      )
                    : Icon(
                        MdiIcons.starOutline,
                        color: theme.colorScheme.primary.withAlpha(40),
                        shadows: kElevationToShadow[1],
                      ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        model.name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      if (model.description.isNotEmpty) ...[
                        const SizedBox(height: 4.0),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            model.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          Container(
            constraints: const BoxConstraints.expand(),
            child: model.isPrivate
                ? Center(
                    child: Icon(
                      MdiIcons.eyeLock,
                      color: const Color(0xFFFFA600),
                      shadows: kElevationToShadow[1],
                    ),
                  )
                : null,
          ),
        ),
        DataCell(
          Container(
            constraints: const BoxConstraints.expand(),
            child: model.autoClear
                ? Center(
                    child: Icon(
                      MdiIcons.deleteClockOutline,
                      color: const Color(0xFF0084FF),
                      shadows: kElevationToShadow[1],
                    ),
                  )
                : null,
          ),
        ),
        DataCell(
          Container(
            constraints: const BoxConstraints.expand(),
            child: Center(
              child: Text(
                (model.totalAssets > 0)
                    ? NumberFormat('#,##0').format(
                        model.totalAssets,
                      )
                    : '-',
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  color: (model.totalAssets == 0)
                      ? theme.colorScheme.primary.withAlpha(100)
                      : null,
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${model.ownedBy.firstName} ${model.ownedBy.lastName}'.trim(),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            constraints: const BoxConstraints.expand(),
            child: Center(
              child: Text(
                DateFormat.yMd().add_jms().format(model.createdAt),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onDataRowSecondaryTap({
    required BuildContext context,
    required int index,
    required String collectionID,
  }) {
    final selectedIDs = <String>[];

    selectedIDs.addAll(widget.selectedIDs);

    if (!HardwareKeyboard.instance.isShiftPressed) {
      _selectionStart = index != -1 ? index : null;

      if (!selectedIDs.any((id) => id == collectionID)) {
        if (!HardwareKeyboard.instance.isControlPressed &&
            !HardwareKeyboard.instance.isMetaPressed) {
          selectedIDs.clear();
        }

        selectedIDs.add(collectionID);
      }
    } else {
      _selectionEnd = index != -1 ? index : null;

      if ((_selectionStart != null) && (_selectionEnd != null)) {
        if (_selectionStart! < _selectionEnd!) {
          selectedIDs.addAll(
            widget.collections
                .getRange(_selectionStart!, _selectionEnd! + 1)
                .where((_) => !selectedIDs.any((id) => id == _.id))
                .map((_) => _.id),
          );
        } else if (_selectionEnd! < _selectionStart!) {
          selectedIDs.addAll(
            widget.collections
                .getRange(_selectionEnd!, _selectionStart!)
                .where((_) => !selectedIDs.any((id) => id == _.id))
                .map((_) => _.id),
          );
        }
      }
    }

    widget.onSelectionChanged(selectedIDs);

    context.contextMenuOverlay.show(_buildContextMenu(context));
  }

  void _onDataRowSelectChanged({
    required int index,
    required String collectionID,
    required bool? selected,
  }) {
    _lastSelectionState = selected;

    final selectedIDs = <String>[];

    selectedIDs.addAll(widget.selectedIDs);

    if (!HardwareKeyboard.instance.isShiftPressed) {
      _selectionStart = index != -1 ? index : null;

      if (!selectedIDs.any((id) => id == collectionID)) {
        if (!HardwareKeyboard.instance.isControlPressed &&
            !HardwareKeyboard.instance.isMetaPressed) {
          selectedIDs.clear();
        }
        selectedIDs.add(collectionID);
      } else {
        if (HardwareKeyboard.instance.isControlPressed ||
            HardwareKeyboard.instance.isMetaPressed) {
          selectedIDs.removeWhere((id) => id == collectionID);
        } else {
          selectedIDs.removeWhere((id) => id != collectionID);
        }
      }
    } else {
      _selectionEnd = index != -1 ? index : null;

      if ((_selectionStart != null) && (_selectionEnd != null)) {
        if (_selectionStart! < _selectionEnd!) {
          if (_lastSelectionState ?? false) {
            selectedIDs.addAll(
              widget.collections
                  .getRange(_selectionStart!, _selectionEnd! + 1)
                  .where((_) => !selectedIDs.contains(_.id))
                  .map((_) => _.id),
            );
          } else {
            final selection = widget.collections
                .getRange(_selectionStart!, _selectionEnd! + 1)
                .map((_) => _.id);

            selectedIDs.removeWhere(
              (_) => selection.contains(_),
            );
          }
        } else if (_selectionEnd! < _selectionStart!) {
          if (_lastSelectionState ?? false) {
            selectedIDs.addAll(
              widget.collections
                  .getRange(_selectionEnd!, _selectionStart!)
                  .where((_) => !selectedIDs.contains(_.id))
                  .map((_) => _.id),
            );
          } else {
            final selection = widget.collections
                .getRange(_selectionEnd!, _selectionStart!)
                .map((_) => _.id);

            selectedIDs.removeWhere(
              (_) => selection.contains(_),
            );
          }
        }
      }
    }

    widget.onSelectionChanged(selectedIDs);
  }

  void _deselectAll() {
    widget.onSelectionChanged([]);
  }

  void _selectAll() {
    widget.onSelectionChanged(widget.collections.map((_) => _.id).toList());
  }

  void _showEditCollectionDialog({
    required BuildContext context,
    required CollectionModel model,
  }) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: false,
      builder: (_) {
        return OverflowBox(
          minWidth: 600.0,
          maxWidth: 600.0,
          child: Center(
            child: EditCollectionModal(
              theme: Theme.of(context),
              model: model,
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSave: (params) {
                BlocProvider.of<CollectionsBloc>(context).add(
                  SaveCollectionEvent(
                    collectionID: params.collectionID,
                    name: params.name,
                    description: params.description,
                    isPrivate: params.isPrivate,
                    autoClear: params.autoClear,
                  ),
                );

                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}
