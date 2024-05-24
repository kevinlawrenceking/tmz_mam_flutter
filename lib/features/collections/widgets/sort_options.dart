import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/collection_sort_field_enum.dart';
import 'package:tmz_damz/data/models/shared.dart';
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';
import 'package:tmz_damz/shared/widgets/toolbar_button.dart';

typedef SortOptionsChangedCallback = void Function(
  CollectionSortFieldEnum field,
  SortDirectionEnum direction,
);

class SortOptions extends StatelessWidget {
  final CollectionSortFieldEnum initialField;
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
        const SizedBox(width: 4.0),
        _buildSortDirectionButton(),
      ],
    );
  }

  Widget _buildFieldSelector() {
    return SizedBox(
      width: 240.0,
      child: DropdownSelector<CollectionSortFieldEnum>(
        initialValue: initialField,
        items: const [
          CollectionSortFieldEnum.name,
          CollectionSortFieldEnum.createdAt,
          CollectionSortFieldEnum.updatedAt,
          CollectionSortFieldEnum.autoClear,
          CollectionSortFieldEnum.favorited,
        ],
        itemBuilder: (value) {
          final label = {
                CollectionSortFieldEnum.name: 'Name',
                CollectionSortFieldEnum.createdAt: 'Date Created',
                CollectionSortFieldEnum.updatedAt: 'Date Updated',
                CollectionSortFieldEnum.autoClear: 'Auto-Clear',
                CollectionSortFieldEnum.favorited: 'Favorited',
              }[value] ??
              '';

          return Text(label);
        },
        onSelectionChanged: (value) => onChanged(
          value ?? CollectionSortFieldEnum.createdAt,
          initialDirection,
        ),
      ),
    );
  }

  Widget _buildSortDirectionButton() {
    IconData icon;

    if ((initialField == CollectionSortFieldEnum.createdAt) ||
        (initialField == CollectionSortFieldEnum.updatedAt)) {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.sortCalendarDescending
          : MdiIcons.sortCalendarAscending;
    } else if (initialField == CollectionSortFieldEnum.autoClear) {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.sortBoolDescending
          : MdiIcons.sortBoolAscending;
    } else if (initialField == CollectionSortFieldEnum.favorited) {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.starSettings
          : MdiIcons.starSettingsOutline;
    } else {
      icon = initialDirection == SortDirectionEnum.descending
          ? MdiIcons.sortAlphabeticalDescending
          : MdiIcons.sortAlphabeticalAscending;
    }

    return SizedBox(
      width: 46,
      height: 42,
      child: ToolbarButton(
        icon: icon,
        onPressed: () {
          onChanged(
            initialField,
            initialDirection == SortDirectionEnum.ascending
                ? SortDirectionEnum.descending
                : SortDirectionEnum.ascending,
          );
        },
      ),
    );
  }
}
