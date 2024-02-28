import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_mam_flutter/data/models/inventory_sort_field_enum.dart';
import 'package:tmz_mam_flutter/data/models/sort_direction_enum.dart';
import 'package:tmz_mam_flutter/shared/widgets/dropdown_selector.dart';

typedef SortOptionsChangedCallback = void Function(
  InventorySortFieldEnum? field,
  SortDirectionEnum direction,
);

class SortOptions extends StatelessWidget {
  final InventorySortFieldEnum? initialField;
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
      child: DropdownSelector<InventorySortFieldEnum?>(
        initialValue: initialField,
        items: const [
          InventorySortFieldEnum.id,
          InventorySortFieldEnum.name,
          InventorySortFieldEnum.dateCreated,
          InventorySortFieldEnum.dateUpdated,
        ],
        itemBuilder: (value) {
          final label = {
                InventorySortFieldEnum.id: 'ID',
                InventorySortFieldEnum.name: 'Name',
                InventorySortFieldEnum.dateCreated: 'Date Created',
                InventorySortFieldEnum.dateUpdated: 'Date Updated',
              }[value] ??
              '';

          return Text(label);
        },
        onSelectionChanged: (value) => onChanged(value, initialDirection),
      ),
    );
  }

  Widget _buildSortDirectionButton() {
    IconData icon;

    if ((initialField == InventorySortFieldEnum.dateCreated) ||
        (initialField == InventorySortFieldEnum.dateUpdated)) {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.sortCalendarAscending
          : MdiIcons.sortCalendarDescending;
    } else if (initialField == InventorySortFieldEnum.id) {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.sortNumericDescendingVariant
          : MdiIcons.sortNumericAscendingVariant;
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
