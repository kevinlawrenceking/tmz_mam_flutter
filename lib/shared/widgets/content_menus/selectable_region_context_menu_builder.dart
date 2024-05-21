import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget Function(
  BuildContext context,
  SelectableRegionState selectableRegionState,
  VoidCallback onCopy,
) kSelectableRegionContextMenuBuilder = (
  context,
  selectableRegionState,
  onCopy,
) {
  return Align(
    alignment: Alignment.topLeft,
    child: Transform.translate(
      offset: selectableRegionState.contextMenuAnchors.primaryAnchor,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: GenericContextMenu(
            buttonConfigs: [
              ContextMenuButtonConfig(
                'Copy',
                shortcutLabel: 'Ctrl+C, Cmd+C',
                icon: Icon(
                  MdiIcons.contentCopy,
                  size: 16.0,
                ),
                onPressed: selectableRegionState.copyEnabled
                    ? () async {
                        selectableRegionState.hideToolbar();
                        onCopy();
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
                onPressed: selectableRegionState.selectAllEnabled
                    ? () {
                        selectableRegionState
                            .selectAll(SelectionChangedCause.toolbar);
                        selectableRegionState.hideToolbar();
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
