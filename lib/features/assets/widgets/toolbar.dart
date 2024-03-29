import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_damz/features/assets/widgets/search_input.dart';
import 'package:tmz_damz/features/assets/widgets/sort_options.dart';
import 'package:tmz_damz/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_damz/features/assets/widgets/toolbar_button.dart';

class Toolbar extends StatefulWidget {
  final TextEditingController? searchTermController;
  final AssetSortFieldEnum sortField;
  final SortDirectionEnum sortDirection;
  final LayoutModeEnum layoutMode;
  final ThumbnailSizeEnum thumbnailSize;
  final VoidCallback onReload;
  final void Function() onSearchTermClear;
  final void Function(String searchTerm) onSearchTermChange;
  final SortOptionsChangedCallback onSortChanged;
  final void Function(LayoutModeEnum mode) onLayoutChange;
  final void Function(ThumbnailSizeEnum size) onThumbnailSizeChange;

  const Toolbar({
    super.key,
    required this.searchTermController,
    required this.sortField,
    required this.sortDirection,
    required this.layoutMode,
    required this.thumbnailSize,
    required this.onReload,
    required this.onSearchTermClear,
    required this.onSearchTermChange,
    required this.onSortChanged,
    required this.onLayoutChange,
    required this.onThumbnailSizeChange,
  });

  @override
  State<Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  @override
  Widget build(BuildContext context) {
    return _buildContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 46,
                      height: 44,
                      child: ToolbarButton(
                        icon: MdiIcons.rotateRight,
                        onPressed: widget.onReload,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: SearchInput(
                        controller: widget.searchTermController,
                        onClear: widget.onSearchTermClear,
                        onFieldSubmitted: widget.onSearchTermChange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    SortOptions(
                      initialField: widget.sortField,
                      initialDirection: widget.sortDirection,
                      onChanged: widget.onSortChanged,
                    ),
                    const Spacer(),
                    const SizedBox(width: 20.0),
                    ThumbnailSizeSelector(
                      initialSize: widget.thumbnailSize,
                      onChanged: widget.onThumbnailSizeChange,
                    ),
                    const SizedBox(width: 20.0),
                    LayoutModeSelector(
                      initialMode: widget.layoutMode,
                      onChanged: widget.onLayoutChange,
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Row(
              children: [
                SizedBox(
                  width: 46,
                  height: 44,
                  child: ToolbarButton(
                    icon: MdiIcons.rotateRight,
                    onPressed: widget.onReload,
                  ),
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  child: SearchInput(
                    controller: widget.searchTermController,
                    onClear: widget.onSearchTermClear,
                    onFieldSubmitted: widget.onSearchTermChange,
                  ),
                ),
                const SizedBox(width: 20.0),
                SortOptions(
                  initialField: widget.sortField,
                  initialDirection: widget.sortDirection,
                  onChanged: widget.onSortChanged,
                ),
                const SizedBox(width: 20.0),
                ThumbnailSizeSelector(
                  initialSize: widget.thumbnailSize,
                  onChanged: widget.onThumbnailSizeChange,
                ),
                const SizedBox(width: 20.0),
                LayoutModeSelector(
                  initialMode: widget.layoutMode,
                  onChanged: widget.onLayoutChange,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildContainer({
    required Widget child,
  }) {
    return Container(
      color: const Color(0xFF232323),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
            child: child,
          ),
        ),
      ),
    );
  }
}
