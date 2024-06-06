import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/shared.dart';
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';
import 'package:tmz_damz/shared/widgets/toolbar_button.dart';

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
        const SizedBox(width: 4.0),
        _buildSortDirectionButton(),
      ],
    );
  }

  Widget _buildFieldSelector() {
    return SizedBox(
      width: 240.0,
      child: DropdownSelector<AssetSortFieldEnum>(
        initialValue: initialField,
        items: const [
          AssetSortFieldEnum.headline,
          AssetSortFieldEnum.createdAt,
          AssetSortFieldEnum.updatedAt,
          AssetSortFieldEnum.agency,
          AssetSortFieldEnum.celebrityAssociated,
          AssetSortFieldEnum.celebrityInPhoto,
          AssetSortFieldEnum.credit,
          AssetSortFieldEnum.creditLocation,
          AssetSortFieldEnum.keywords,
          AssetSortFieldEnum.originalFileName,
          AssetSortFieldEnum.rights,
          AssetSortFieldEnum.rightsDetails,
          AssetSortFieldEnum.shotDescription,
        ],
        itemBuilder: (value) {
          final label = {
                AssetSortFieldEnum.headline: 'Headline',
                AssetSortFieldEnum.createdAt: 'Date Created',
                AssetSortFieldEnum.updatedAt: 'Date Updated',
                AssetSortFieldEnum.agency: 'Agency',
                AssetSortFieldEnum.celebrityAssociated:
                    'Celebrity (Associated)',
                AssetSortFieldEnum.celebrityInPhoto: 'Celebrity (In Photo)',
                AssetSortFieldEnum.credit: 'Credit',
                AssetSortFieldEnum.creditLocation: 'Credit Location',
                AssetSortFieldEnum.keywords: 'Keywords',
                AssetSortFieldEnum.originalFileName: 'Original File Name',
                AssetSortFieldEnum.rights: 'Rights Summary',
                AssetSortFieldEnum.rightsDetails: 'Rights Details',
                AssetSortFieldEnum.shotDescription: 'Shot Description',
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
      icon = (initialDirection == SortDirectionEnum.descending)
          ? MdiIcons.sortCalendarDescending
          : MdiIcons.sortCalendarAscending;
    } else {
      icon = (initialDirection == SortDirectionEnum.descending)
          ? MdiIcons.sortAlphabeticalDescending
          : MdiIcons.sortAlphabeticalAscending;
    }

    return SizedBox(
      width: 46,
      height: 42,
      child: ToolbarButton(
        icon: icon,
        tooltip: (initialDirection == SortDirectionEnum.ascending)
            ? 'Sort Ascending'
            : 'Sort Descending',
        onPressed: () {
          onChanged(
            initialField,
            (initialDirection == SortDirectionEnum.ascending)
                ? SortDirectionEnum.descending
                : SortDirectionEnum.ascending,
          );
        },
      ),
    );
  }
}
