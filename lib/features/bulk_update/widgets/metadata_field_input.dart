import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:tmz_damz/data/models/asset_metadata_field.dart';
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';

class MetadataFieldInput extends StatefulWidget {
  final bool canAdd;
  final bool showModeSelection;
  final List<AssetMetadataFieldEnum> fields;
  final List<AssetMetadataFieldModeEnum> modes;
  final AssetMetadataFieldEnum? initialField;
  final AssetMetadataFieldModeEnum? initialMode;
  final Widget? inputWidget;
  final void Function(
    AssetMetadataFieldEnum? field,
    AssetMetadataFieldModeEnum mode,
  ) onFieldSelected;
  final void Function(AssetMetadataFieldModeEnum mode) onModeSelected;
  final VoidCallback onAddField;
  final VoidCallback onRemoveField;

  const MetadataFieldInput({
    super.key,
    required this.canAdd,
    this.showModeSelection = true,
    required this.fields,
    required this.modes,
    required this.initialField,
    required this.initialMode,
    required this.inputWidget,
    required this.onFieldSelected,
    required this.onModeSelected,
    required this.onAddField,
    required this.onRemoveField,
  });

  @override
  State<MetadataFieldInput> createState() => _MetadataFieldInputState();
}

class _MetadataFieldInputState extends State<MetadataFieldInput> {
  final _radioGroupController =
      RadioGroupController<AssetMetadataFieldModeEnum>();

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
            widget.canAdd ? _buildAddButton() : _buildRemoveButton(),
          ],
        ),
        if ((widget.inputWidget != null) && widget.showModeSelection)
          TableRow(
            children: [
              const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RadioGroup(
                    controller: _radioGroupController,
                    values: widget.modes,
                    indexOfDefault: widget.modes.indexOf(
                      widget.initialMode ?? AssetMetadataFieldModeEnum.replace,
                    ),
                    orientation: RadioGroupOrientation.horizontal,
                    decoration: const RadioGroupDecoration(
                      spacing: 10.0,
                      activeColor: Colors.blue,
                    ),
                    labelBuilder: (value) {
                      return Text(
                        {
                              AssetMetadataFieldModeEnum.add: 'Add',
                              AssetMetadataFieldModeEnum.append: 'Append',
                              AssetMetadataFieldModeEnum.prepend: 'Prepend',
                              AssetMetadataFieldModeEnum.remove: 'Remove',
                              AssetMetadataFieldModeEnum.replace: 'Replace',
                            }[value] ??
                            '',
                      );
                    },
                    onChanged: widget.onModeSelected,
                  ),
                ),
              ),
              const SizedBox.shrink(),
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
        child: DropdownSelector<AssetMetadataFieldEnum>(
          initialValue: widget.initialField,
          items: widget.fields,
          itemBuilder: (value) {
            final label = {
                  AssetMetadataFieldEnum.agency: 'Agency',
                  AssetMetadataFieldEnum.celebrityAssociated:
                      'Celebrity (Associated)',
                  AssetMetadataFieldEnum.celebrityInPhoto:
                      'Celebrity (In Photo)',
                  AssetMetadataFieldEnum.credit: 'Credit',
                  AssetMetadataFieldEnum.creditLocation: 'Credit Location',
                  AssetMetadataFieldEnum.emotion: 'Emotions',
                  AssetMetadataFieldEnum.headline: 'Headline',
                  AssetMetadataFieldEnum.keywords: 'Keywords',
                  AssetMetadataFieldEnum.locationCity: 'City',
                  AssetMetadataFieldEnum.locationCountry: 'Country',
                  AssetMetadataFieldEnum.locationDescription: 'Shoot Location',
                  AssetMetadataFieldEnum.locationState: 'State',
                  AssetMetadataFieldEnum.overlay: 'Overlays',
                  AssetMetadataFieldEnum.qcNotes: 'QC Notes',
                  AssetMetadataFieldEnum.rights: 'Rights Summary',
                  AssetMetadataFieldEnum.rightsDetails: 'Rights Details',
                  AssetMetadataFieldEnum.rightsInstructions:
                      'Rights Instructions',
                  AssetMetadataFieldEnum.shotDescription: 'Shot Description',
                }[value] ??
                '';

            return Text(label);
          },
          onSelectionChanged: (value) => widget.onFieldSelected(
            value,
            ((_radioGroupController.myRadioGroupKey != null)
                    ? _radioGroupController.value
                    : null) ??
                AssetMetadataFieldModeEnum.replace,
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
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF11853F),
          ),
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
          backgroundColor: MaterialStateProperty.all(
            const Color(0x30FFFFFF),
          ),
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
          MdiIcons.minus,
          size: 16.0,
        ),
      ),
    );
  }
}
