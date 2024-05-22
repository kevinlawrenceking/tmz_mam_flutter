import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget Function(
  BuildContext context,
  EditableTextState editableTextState,
  UndoHistoryController? undoController,
) kEditableTextContextMenuBuilder = (
  context,
  editableTextState,
  undoController,
) {
  return Align(
    alignment: Alignment.topLeft,
    child: Transform.translate(
      offset: editableTextState.contextMenuAnchors.primaryAnchor,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: GenericContextMenu(
            buttonConfigs: [
              if (undoController != null) ...[
                ContextMenuButtonConfig(
                  'Undo',
                  shortcutLabel: 'Ctrl+Z, Cmd+Z',
                  icon: Icon(
                    MdiIcons.arrowULeftTop,
                    size: 16.0,
                  ),
                  onPressed: undoController.value.canUndo
                      ? () {
                          undoController.undo();
                          editableTextState.hideToolbar();
                        }
                      : null,
                ),
                ContextMenuButtonConfig(
                  'Redo',
                  shortcutLabel: 'Ctrl+Shift+Z, Cmd+Shift+Z',
                  icon: Icon(
                    MdiIcons.arrowURightTop,
                    size: 16.0,
                  ),
                  onPressed: undoController.value.canRedo
                      ? () {
                          undoController.redo();
                          editableTextState.hideToolbar();
                        }
                      : null,
                ),
                null, // divider
              ],
              ContextMenuButtonConfig(
                'Cut',
                shortcutLabel: 'Ctrl+X, Cmd+X',
                icon: Icon(
                  MdiIcons.contentCut,
                  size: 16.0,
                ),
                onPressed: editableTextState.cutEnabled
                    ? () {
                        editableTextState
                            .cutSelection(SelectionChangedCause.toolbar);
                        editableTextState.hideToolbar();
                      }
                    : null,
              ),
              ContextMenuButtonConfig(
                'Copy',
                shortcutLabel: 'Ctrl+C, Cmd+C',
                icon: Icon(
                  MdiIcons.contentCopy,
                  size: 16.0,
                ),
                onPressed: editableTextState.copyEnabled
                    ? () {
                        editableTextState
                            .copySelection(SelectionChangedCause.toolbar);
                        editableTextState.hideToolbar();
                      }
                    : null,
              ),
              ContextMenuButtonConfig(
                'Paste',
                shortcutLabel: 'Ctrl+V, Cmd+V',
                icon: Icon(
                  MdiIcons.contentDuplicate,
                  size: 16.0,
                ),
                onPressed: editableTextState.pasteEnabled
                    ? () async {
                        await editableTextState
                            .pasteText(SelectionChangedCause.toolbar);
                        editableTextState.hideToolbar();
                      }
                    : null,
              ),
              null, // divider
              ContextMenuButtonConfig(
                'Select All',
                shortcutLabel: 'Ctrl+A, Cmd+A',
                icon: const SizedBox.square(
                  dimension: 16.0,
                ),
                onPressed: editableTextState.selectAllEnabled
                    ? () {
                        editableTextState
                            .selectAll(SelectionChangedCause.toolbar);
                        editableTextState.hideToolbar();
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    ),
  );
};
