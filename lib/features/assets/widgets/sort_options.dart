import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';

typedef SortOptionsChangedCallback = void Function(
  AssetSortFieldEnum field,
  SortDirectionEnum direction,
);

class SortOptions extends StatelessWidget {
  final AssetSortFieldEnum initialField;
  final SortDirectionEnum initialDirection;
  final SortOptionsChangedCallback onChanged;

  const SortOptions({
    super.key,
    required this.initialField,
    required this.initialDirection,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildFieldSelector(),
        const SizedBox(width: 4),
        _buildSortDirectionButton(),
      ],
    );
  }

  Widget _buildFieldSelector() {
    return SizedBox(
      width: 170,
      child: DropdownSelector<AssetSortFieldEnum>(
        initialValue: initialField,
        items: const [
          AssetSortFieldEnum.headline,
          AssetSortFieldEnum.createdAt,
          AssetSortFieldEnum.updatedAt,
        ],
        itemBuilder: (value) {
          final label = {
                AssetSortFieldEnum.headline: 'Headline',
                AssetSortFieldEnum.createdAt: 'Date Created',
                AssetSortFieldEnum.updatedAt: 'Date Updated',
              }[value] ??
              '';

          return Text(label);
        },
        onSelectionChanged: (value) => onChanged(
          value ?? AssetSortFieldEnum.createdAt,
          initialDirection,
        ),
      ),
    );
  }

  Widget _buildSortDirectionButton() {
    IconData icon;

    if ((initialField == AssetSortFieldEnum.createdAt) ||
        (initialField == AssetSortFieldEnum.updatedAt)) {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.sortCalendarAscending
          : MdiIcons.sortCalendarDescending;
    } else {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.sortAlphabeticalDescendingVariant
          : MdiIcons.sortAlphabeticalAscendingVariant;
    }

    return SizedBox(
      width: 46,
      height: 40,
      child: IconButton(
        onPressed: () {
          onChanged(
            initialField,
            initialDirection == SortDirectionEnum.ascending
                ? SortDirectionEnum.descending
                : SortDirectionEnum.ascending,
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0x30FFFFFF)),
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
          icon,
          color: const Color(0xAEFFFFFF),
          size: 24,
        ),
      ),
    );
  }
}
