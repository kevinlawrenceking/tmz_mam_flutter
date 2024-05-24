import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_search_data.dart';
import 'package:tmz_damz/data/models/shared.dart';
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';

class AdvancedSearchMetadataFieldInput extends StatefulWidget {
  final bool canAdd;
  final List<AssetSearchMetadataFieldEnum> fields;
  final AssetSearchMetadataFieldEnum? initialField;
  final ComparisonMethodEnum? initialComparisonMethod;
  final Widget? inputWidget;
  final void Function(AssetSearchMetadataFieldEnum? field) onFieldSelected;
  final VoidCallback onAddField;
  final VoidCallback onRemoveField;

  const AdvancedSearchMetadataFieldInput({
    super.key,
    required this.canAdd,
    required this.fields,
    required this.initialField,
    required this.initialComparisonMethod,
    required this.inputWidget,
    required this.onFieldSelected,
    required this.onAddField,
    required this.onRemoveField,
  });

  @override
  State<AdvancedSearchMetadataFieldInput> createState() =>
      _AdvancedSearchMetadataFieldInputState();
}

class _AdvancedSearchMetadataFieldInputState
    extends State<AdvancedSearchMetadataFieldInput> {
  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            _buildFieldSelector(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: widget.inputWidget ??
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: Colors.white12,
                    dashPattern: const [8, 4],
                    padding: EdgeInsets.zero,
                    radius: const Radius.circular(6.0),
                    strokeCap: StrokeCap.round,
                    child: const SizedBox(height: 42.0),
                  ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: widget.canAdd ? _buildAddButton() : _buildRemoveButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFieldSelector() {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: SizedBox(
        height: 45.0,
        width: 240.0,
        child: DropdownSelector<AssetSearchMetadataFieldEnum>(
          initialValue: widget.initialField,
          items: widget.fields,
          itemBuilder: (value) {
            final label = {
                  AssetSearchMetadataFieldEnum.agency: 'Agency',
                  AssetSearchMetadataFieldEnum.celebrityAssociated:
                      'Celebrity (Associated)',
                  AssetSearchMetadataFieldEnum.celebrityInPhoto:
                      'Celebrity (In Photo)',
                  AssetSearchMetadataFieldEnum.credit: 'Credit',
                  AssetSearchMetadataFieldEnum.creditLocation:
                      'Credit Location',
                  AssetSearchMetadataFieldEnum.daletID: 'Dalet ID',
                  AssetSearchMetadataFieldEnum.emotions: 'Emotions',
                  AssetSearchMetadataFieldEnum.headline: 'Headline',
                  AssetSearchMetadataFieldEnum.keywords: 'Keywords',
                  AssetSearchMetadataFieldEnum.originalFileName:
                      'Original File Name',
                  AssetSearchMetadataFieldEnum.overlays: 'Overlays',
                  AssetSearchMetadataFieldEnum.qcNotes: 'QC Notes',
                  AssetSearchMetadataFieldEnum.rights: 'Rights Summary',
                  AssetSearchMetadataFieldEnum.rightsDetails: 'Rights Details',
                  AssetSearchMetadataFieldEnum.rightsInstructions:
                      'Rights Instructions',
                  AssetSearchMetadataFieldEnum.shotDescription:
                      'Shot Description',
                }[value] ??
                '';

            return Text(label);
          },
          onSelectionChanged: (value) => widget.onFieldSelected(
            value,
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      height: 28.0,
      width: 28.0,
      child: IconButton(
        onPressed: widget.onAddField,
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0xFF11853F),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.resolveWith(
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
          MdiIcons.plus,
          size: 16.0,
        ),
      ),
    );
  }

  Widget _buildRemoveButton() {
    return SizedBox(
      height: 28.0,
      width: 28.0,
      child: IconButton(
        onPressed: widget.onRemoveField,
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.resolveWith(
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
          MdiIcons.minus,
          size: 16.0,
        ),
      ),
    );
  }
}
