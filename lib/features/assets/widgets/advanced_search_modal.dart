import 'package:choice/choice.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/data/models/asset_search_data.dart';
import 'package:tmz_damz/data/models/shared.dart';
import 'package:tmz_damz/data/models/user.dart';
import 'package:tmz_damz/features/assets/widgets/advanced_search_metadata_field_input.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_agency_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_celebrity_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_keyword_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_user_tag_field.dart';
import 'package:tmz_damz/shared/widgets/calendar_date_picker.dart' as widgets;
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';

class AdvancedSearchModal extends StatefulWidget {
  final ThemeData theme;
  final AssetSearchDataModel? searchData;
  final VoidCallback onCancel;
  final void Function(AssetSearchDataModel searchData) onSearch;

  const AdvancedSearchModal({
    super.key,
    required this.theme,
    required this.searchData,
    required this.onCancel,
    required this.onSearch,
  });

  @override
  State<AdvancedSearchModal> createState() => _AdvancedSearchModalState();
}

class _AdvancedSearchModalState extends State<AdvancedSearchModal> {
  late final TextEditingController _searchTermController;
  late final List<_InputFieldData> _fieldData;

  DateTime? _createdAtStart;
  DateTime? _createdAtEnd;
  DateTime? _updatedAtStart;
  DateTime? _updatedAtEnd;

  @override
  void dispose() {
    _searchTermController.dispose();

    for (var i = 0; i < _fieldData.length; i++) {
      _fieldData[i].focusNode.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _searchTermController = TextEditingController(
      text: widget.searchData?.searchTerm,
    );

    _createdAtStart = widget.searchData?.createdAtStart;
    _createdAtEnd = widget.searchData?.createdAtEnd;
    _updatedAtStart = widget.searchData?.updatedAtStart;
    _updatedAtEnd = widget.searchData?.updatedAtEnd;

    if (widget.searchData?.metadataConditions.isNotEmpty ?? false) {
      _fieldData = widget.searchData!.metadataConditions
          .map(
            (_) => _InputFieldData(
              condition: _,
            ),
          )
          .toList();
    } else {
      _fieldData = <_InputFieldData>[_InputFieldData()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1D1E1F),
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: kElevationToShadow[8],
        color: const Color(0xFF232323),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle('Advanced search...'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MaskedScrollView(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  top: 30.0,
                  right: 40.0,
                  bottom: 10.0,
                ),
                child: FocusScope(
                  child: _buildContent(
                    context: context,
                  ),
                ),
              ),
              _buildDialogButtons(
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 230.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Created',
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white.withAlpha(20),
              ),
              child: widgets.CalendarDatePickerDropdown(
                selectedDate: _createdAtStart,
                onValueChanged: (value) {
                  setState(() {
                    if ((value?.millisecondsSinceEpoch ?? 0) >
                        (_createdAtEnd?.millisecondsSinceEpoch ?? 0)) {
                      _createdAtEnd = null;
                    }

                    _createdAtStart = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 100.0,
              child: TextButton(
                onPressed: (_createdAtStart != null)
                    ? () {
                        setState(() {
                          _createdAtStart = null;
                        });
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0x30FFFFFF),
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Clear',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: (_createdAtStart == null) ? Colors.black54 : null,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Icon(
                MdiIcons.chevronTripleRight,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white.withAlpha(20),
              ),
              child: widgets.CalendarDatePickerDropdown(
                selectedDate: _createdAtEnd,
                onValueChanged: (value) {
                  setState(() {
                    if ((value?.millisecondsSinceEpoch ?? 0) <
                        (_createdAtStart?.millisecondsSinceEpoch ?? 0)) {
                      _createdAtStart = null;
                    }

                    _createdAtEnd = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 100.0,
              child: TextButton(
                onPressed: (_createdAtEnd != null)
                    ? () {
                        setState(() {
                          _createdAtEnd = null;
                        });
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0x30FFFFFF),
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Clear',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: (_createdAtEnd == null) ? Colors.black54 : null,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            const SizedBox(
              width: 230.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Updated',
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white.withAlpha(20),
              ),
              child: widgets.CalendarDatePickerDropdown(
                selectedDate: _updatedAtStart,
                onValueChanged: (value) {
                  setState(() {
                    if ((value?.millisecondsSinceEpoch ?? 0) >
                        (_updatedAtEnd?.millisecondsSinceEpoch ?? 0)) {
                      _updatedAtEnd = null;
                    }

                    _updatedAtStart = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 100.0,
              child: TextButton(
                onPressed: (_updatedAtStart != null)
                    ? () {
                        setState(() {
                          _updatedAtStart = null;
                        });
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0x30FFFFFF),
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Clear',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: (_updatedAtStart == null) ? Colors.black54 : null,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Icon(
                MdiIcons.chevronTripleRight,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white.withAlpha(20),
              ),
              child: widgets.CalendarDatePickerDropdown(
                selectedDate: _updatedAtEnd,
                onValueChanged: (value) {
                  setState(() {
                    if ((value?.millisecondsSinceEpoch ?? 0) <
                        (_updatedAtStart?.millisecondsSinceEpoch ?? 0)) {
                      _updatedAtStart = null;
                    }

                    _updatedAtEnd = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              width: 100.0,
              child: TextButton(
                onPressed: (_updatedAtEnd != null)
                    ? () {
                        setState(() {
                          _updatedAtEnd = null;
                        });
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0x30FFFFFF),
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Clear',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: (_updatedAtEnd == null) ? Colors.black54 : null,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            const SizedBox(
              width: 230.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Search Term',
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                controller: _searchTermController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      MdiIcons.close,
                      color: const Color(0xDEFFFFFF),
                      size: 22,
                    ),
                    tooltip: 'Clear search term',
                    onPressed: () {
                      _searchTermController.text = '';
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 38.0),
          ],
        ),
        const SizedBox(height: 20.0),
        ...List.generate(
          _fieldData.length,
          (index) {
            final fieldData = _fieldData[index];

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              child: AdvancedSearchMetadataFieldInput(
                canAdd: index == (_fieldData.length - 1),
                fields: const [
                  AssetSearchMetadataFieldEnum.agency,
                  AssetSearchMetadataFieldEnum.celebrityAssociated,
                  AssetSearchMetadataFieldEnum.celebrityInPhoto,
                  AssetSearchMetadataFieldEnum.createdBy,
                  AssetSearchMetadataFieldEnum.credit,
                  AssetSearchMetadataFieldEnum.creditLocation,
                  AssetSearchMetadataFieldEnum.daletID,
                  AssetSearchMetadataFieldEnum.emotions,
                  AssetSearchMetadataFieldEnum.exclusivity,
                  AssetSearchMetadataFieldEnum.headline,
                  AssetSearchMetadataFieldEnum.keywords,
                  AssetSearchMetadataFieldEnum.originalFileName,
                  AssetSearchMetadataFieldEnum.overlays,
                  AssetSearchMetadataFieldEnum.qcNotes,
                  AssetSearchMetadataFieldEnum.rightsDetails,
                  AssetSearchMetadataFieldEnum.rightsInstructions,
                  AssetSearchMetadataFieldEnum.rights, // Rights Summary
                  AssetSearchMetadataFieldEnum.shotDescription,
                ]
                    .where(
                      (field) =>
                          (field == fieldData.condition?.field) ||
                          ![
                            // make sure we only have one instance
                            // of each of these types...
                            AssetSearchMetadataFieldEnum.creditLocation,
                            AssetSearchMetadataFieldEnum.daletID,
                            AssetSearchMetadataFieldEnum.exclusivity,
                            AssetSearchMetadataFieldEnum.rights,
                          ].any(
                            (e) =>
                                (e == field) &&
                                (_fieldData.any(
                                  (f) => f.condition?.field == field,
                                )),
                          ),
                    )
                    .toList(),
                initialField: fieldData.condition?.field,
                initialComparisonMethod: ComparisonMethodEnum.equal,
                inputWidget: _buildInputField(
                  theme: theme,
                  fieldData: fieldData,
                ),
                onFieldSelected: (field) {
                  setState(() {
                    _fieldData[index].condition = (field != null)
                        ? AssetSearchDataMetadataConditionModel(
                            field: field,
                            comparisonMethod:
                                _getDefaultComparisonMethod(field),
                            value: _getDefaultValue(field),
                          )
                        : null;
                  });
                },
                onAddField: () {
                  setState(() {
                    _fieldData.add(_InputFieldData());
                  });
                },
                onRemoveField: () {
                  setState(() {
                    final field = _fieldData[index];
                    field.focusNode.dispose();
                    field.condition = null;
                    _fieldData.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDialogButtons({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _createdAtStart = null;
                _createdAtEnd = null;
                _updatedAtStart = null;
                _updatedAtEnd = null;

                for (var i = _fieldData.length - 1; i >= 0; i--) {
                  final field = _fieldData[i];
                  field.focusNode.dispose();
                  field.condition = null;
                  _fieldData.removeAt(i);
                }

                _fieldData.add(_InputFieldData());
              });
            },
            style: widget.theme.textButtonTheme.style,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Text(
                'Remove All Conditions',
                style: widget.theme.textTheme.bodySmall,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 100.0,
            child: TextButton(
              onPressed: () {
                widget.onSearch(
                  AssetSearchDataModel(
                    createdAtStart: _createdAtStart,
                    createdAtEnd: _createdAtEnd,
                    updatedAtStart: _updatedAtStart,
                    updatedAtEnd: _updatedAtEnd,
                    searchTerm: _searchTermController.text.trim(),
                    metadataConditions: _fieldData
                        .where((_) => _.condition != null)
                        .map((_) => _.condition!)
                        .toList(),
                  ),
                );
              },
              style: widget.theme.textButtonTheme.style,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'Apply',
                  style: widget.theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 100.0,
            child: TextButton(
              onPressed: widget.onCancel,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color(0x30FFFFFF),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                ),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'Cancel',
                  style: widget.theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      color: const Color(0xFF1D1E1F),
      child: Text(
        title,
        style: widget.theme.textTheme.titleSmall?.copyWith(
          color: Colors.blue,
          letterSpacing: 1.0,
        ),
        softWrap: true,
      ),
    );
  }

  Widget? _buildInputField({
    required ThemeData theme,
    required _InputFieldData fieldData,
  }) {
    if (fieldData.condition?.field == null) {
      return null;
    }

    switch (fieldData.condition!.field) {
      case AssetSearchMetadataFieldEnum.agency:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: PicklistAgencyTagField(
                key: fieldData.key,
                focusNode: fieldData.focusNode,
                canAddNewtags: true,
                tags: (fieldData.condition!.value as List<String>?) ?? [],
                onChange: (tags) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: tags,
                    );
                  });

                  fieldData.focusNode.requestFocus();
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.celebrityAssociated:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: PicklistCelebrityTagField(
                key: fieldData.key,
                focusNode: fieldData.focusNode,
                canAddNewtags: true,
                tags: (fieldData.condition!.value as List<String>?) ?? [],
                onChange: (tags) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: tags,
                    );
                  });

                  fieldData.focusNode.requestFocus();
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.celebrityInPhoto:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: PicklistCelebrityTagField(
                key: fieldData.key,
                focusNode: fieldData.focusNode,
                canAddNewtags: true,
                tags: (fieldData.condition!.value as List<String>?) ?? [],
                onChange: (tags) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: tags,
                    );
                  });

                  fieldData.focusNode.requestFocus();
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.createdBy:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: PicklistUserTagField(
                key: fieldData.key,
                focusNode: fieldData.focusNode,
                tags:
                    (fieldData.condition!.value as List<UserMetaModel>?) ?? [],
                onChange: (tags) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: tags.toList(),
                    );
                  });

                  fieldData.focusNode.requestFocus();
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.credit:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                  ComparisonMethodEnum.beginsWith,
                  ComparisonMethodEnum.endsWith,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                        ComparisonMethodEnum.beginsWith: 'Begins With',
                        ComparisonMethodEnum.endsWith: 'Ends With',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: (fieldData.condition!.value as String?) ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: value.trim(),
                  );
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.creditLocation:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Choice<AssetMetadataCreditLocationEnum>.inline(
                clearable: true,
                value: (fieldData.condition!.value != null)
                    ? [fieldData.condition!.value]
                    : [],
                itemCount: 2,
                itemBuilder: (state, index) {
                  const values = [
                    AssetMetadataCreditLocationEnum.end,
                    AssetMetadataCreditLocationEnum.onScreen,
                  ];

                  return ChoiceChip(
                    label: Text(
                      {
                            AssetMetadataCreditLocationEnum.end: 'End',
                            AssetMetadataCreditLocationEnum.onScreen:
                                'On-Screen',
                          }[values[index]] ??
                          '',
                      style: theme.textTheme.bodyMedium,
                    ),
                    selected: fieldData.condition!.value == values[index],
                    selectedColor: const Color(0xFF8E0000),
                    onSelected: (value) {
                      if (value) {
                        state.replace([values[index]]);
                      } else {
                        state.replace([]);
                      }
                    },
                  );
                },
                onChanged: (value) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: value.firstOrNull ??
                          AssetMetadataCreditLocationEnum.unknown,
                    );
                  });
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.daletID:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: fieldData.condition!.value?.toString() ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(30),
                ],
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: Int64.tryParseInt(value),
                  );
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.emotions:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Choice<AssetMetadataEmotionEnum>.inline(
                clearable: true,
                multiple: true,
                value: (fieldData.condition!.value
                        as List<AssetMetadataEmotionEnum>?) ??
                    [],
                itemCount: 4,
                itemBuilder: (state, index) {
                  const values = [
                    AssetMetadataEmotionEnum.positive,
                    AssetMetadataEmotionEnum.negative,
                    AssetMetadataEmotionEnum.surprised,
                    AssetMetadataEmotionEnum.neutral,
                  ];

                  return ChoiceChip(
                    label: Text(
                      {
                            AssetMetadataEmotionEnum.positive: 'Positive',
                            AssetMetadataEmotionEnum.negative: 'Negative',
                            AssetMetadataEmotionEnum.surprised: 'Surprised',
                            AssetMetadataEmotionEnum.neutral: 'Neutral',
                          }[values[index]] ??
                          '',
                      style: theme.textTheme.bodyMedium,
                    ),
                    selected: (fieldData.condition!.value
                                as List<AssetMetadataEmotionEnum>?)
                            ?.contains(values[index]) ??
                        false,
                    selectedColor: const Color(0xFF8E0000),
                    onSelected: (value) {
                      if (value) {
                        state.add(values[index]);
                      } else {
                        state.remove(values[index]);
                      }
                    },
                  );
                },
                onChanged: (value) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: value,
                    );
                  });
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.exclusivity:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Choice<AssetMetadataExclusivityEnum>.inline(
                clearable: true,
                value: (fieldData.condition!.value != null)
                    ? [fieldData.condition!.value]
                    : [],
                itemCount: 2,
                itemBuilder: (state, index) {
                  const values = [
                    AssetMetadataExclusivityEnum.exclusive,
                    AssetMetadataExclusivityEnum.premiumExclusive,
                  ];

                  return ChoiceChip(
                    label: Text(
                      {
                            AssetMetadataExclusivityEnum.exclusive: 'Exclusive',
                            AssetMetadataExclusivityEnum.premiumExclusive:
                                'Premium Exclusive',
                          }[values[index]] ??
                          '',
                      style: theme.textTheme.bodyMedium,
                    ),
                    selected: fieldData.condition!.value == values[index],
                    selectedColor: const Color(0xFF8E0000),
                    onSelected: (value) {
                      if (value) {
                        state.replace([values[index]]);
                      } else {
                        state.replace([]);
                      }
                    },
                  );
                },
                onChanged: (value) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: value.firstOrNull ??
                          AssetMetadataExclusivityEnum.unknown,
                    );
                  });
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.headline:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                  ComparisonMethodEnum.beginsWith,
                  ComparisonMethodEnum.endsWith,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                        ComparisonMethodEnum.beginsWith: 'Begins With',
                        ComparisonMethodEnum.endsWith: 'Ends With',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: (fieldData.condition!.value as String?) ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(250),
                ],
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: value.trim(),
                  );
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.keywords:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: PicklistKeywordTagField(
                key: fieldData.key,
                focusNode: fieldData.focusNode,
                canAddNewtags: true,
                tags: (fieldData.condition!.value as List<String>?) ?? [],
                onChange: (tags) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: tags,
                    );
                  });

                  fieldData.focusNode.requestFocus();
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.originalFileName:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                  ComparisonMethodEnum.beginsWith,
                  ComparisonMethodEnum.endsWith,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                        ComparisonMethodEnum.beginsWith: 'Begins With',
                        ComparisonMethodEnum.endsWith: 'Ends With',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: (fieldData.condition!.value as String?) ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(250),
                ],
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: value.trim(),
                  );
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.overlays:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Choice<AssetMetadataOverlayEnum>.inline(
                clearable: true,
                multiple: true,
                value: (fieldData.condition!.value
                        as List<AssetMetadataOverlayEnum>?) ??
                    [],
                itemCount: 3,
                itemBuilder: (state, index) {
                  const values = [
                    AssetMetadataOverlayEnum.blackBarCensor,
                    AssetMetadataOverlayEnum.blurCensor,
                    AssetMetadataOverlayEnum.watermark,
                  ];

                  return ChoiceChip(
                    label: Text(
                      {
                            AssetMetadataOverlayEnum.blackBarCensor:
                                'Black Bar Censor',
                            AssetMetadataOverlayEnum.blurCensor: 'Blur Censor',
                            AssetMetadataOverlayEnum.watermark: 'Watermark',
                          }[values[index]] ??
                          '',
                      style: theme.textTheme.bodyMedium,
                    ),
                    selected: (fieldData.condition!.value
                                as List<AssetMetadataOverlayEnum>?)
                            ?.contains(values[index]) ??
                        false,
                    selectedColor: const Color(0xFF8E0000),
                    onSelected: (value) {
                      if (value) {
                        state.add(values[index]);
                      } else {
                        state.remove(values[index]);
                      }
                    },
                  );
                },
                onChanged: (value) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value: value,
                    );
                  });
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.qcNotes:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: (fieldData.condition!.value as String?) ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500),
                ],
                maxLines: null,
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: value.trim(),
                  );
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.rights:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Choice<AssetMetadataRightsEnum>.inline(
                clearable: true,
                value: (fieldData.condition!.value != null)
                    ? [fieldData.condition!.value]
                    : [],
                itemCount: 3,
                itemBuilder: (state, index) {
                  const values = [
                    AssetMetadataRightsEnum.freeTMZ,
                    AssetMetadataRightsEnum.freeNonTMZ,
                    AssetMetadataRightsEnum.costNonTMZ,
                  ];

                  return ChoiceChip(
                    label: Text(
                      {
                            AssetMetadataRightsEnum.costNonTMZ:
                                'Cost (Non-TMZ)',
                            AssetMetadataRightsEnum.freeNonTMZ:
                                'Free (Non-TMZ)',
                            AssetMetadataRightsEnum.freeTMZ: 'Free (TMZ)',
                          }[values[index]] ??
                          '',
                      style: theme.textTheme.bodyMedium,
                    ),
                    selected: fieldData.condition!.value == values[index],
                    selectedColor: const Color(0xFF8E0000),
                    onSelected: (value) {
                      if (value) {
                        state.replace([values[index]]);
                      } else {
                        state.replace([]);
                      }
                    },
                  );
                },
                onChanged: (value) {
                  setState(() {
                    fieldData.condition = fieldData.condition!.copyWith(
                      comparisonMethod: fieldData.condition!.comparisonMethod ??
                          _getDefaultComparisonMethod(
                            fieldData.condition!.field,
                          ),
                      value:
                          value.firstOrNull ?? AssetMetadataRightsEnum.unknown,
                    );
                  });
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.rightsDetails:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                  ComparisonMethodEnum.beginsWith,
                  ComparisonMethodEnum.endsWith,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                        ComparisonMethodEnum.beginsWith: 'Begins With',
                        ComparisonMethodEnum.endsWith: 'Ends With',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: (fieldData.condition!.value as String?) ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(250),
                ],
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: value.trim(),
                  );
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.rightsInstructions:
        return Row(
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                  ComparisonMethodEnum.beginsWith,
                  ComparisonMethodEnum.endsWith,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                        ComparisonMethodEnum.beginsWith: 'Begins With',
                        ComparisonMethodEnum.endsWith: 'Ends With',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: (fieldData.condition!.value as String?) ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(250),
                ],
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: value.trim(),
                  );
                },
              ),
            ),
          ],
        );
      case AssetSearchMetadataFieldEnum.shotDescription:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.0,
              width: 210.0,
              child: DropdownSelector<ComparisonMethodEnum>(
                initialValue: fieldData.condition!.comparisonMethod,
                items: const [
                  // these need to match what the backend is
                  // capable of handling for this field...
                  ComparisonMethodEnum.contains,
                  ComparisonMethodEnum.notContains,
                  ComparisonMethodEnum.equal,
                  ComparisonMethodEnum.notEqual,
                ],
                itemBuilder: (value) {
                  final label = {
                        ComparisonMethodEnum.contains: 'Contains',
                        ComparisonMethodEnum.notContains: 'Does Not Contain',
                        ComparisonMethodEnum.equal: 'Equals',
                        ComparisonMethodEnum.notEqual: 'Does Not Equal',
                      }[value] ??
                      '';

                  return Text(label);
                },
                onSelectionChanged: (value) {
                  fieldData.condition =
                      fieldData.condition!.copyWithComparisonMethod(value);
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: (fieldData.condition!.value as String?) ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2000),
                ],
                minLines: 3,
                maxLines: null,
                onChanged: (value) {
                  fieldData.condition = fieldData.condition!.copyWith(
                    comparisonMethod: fieldData.condition!.comparisonMethod ??
                        _getDefaultComparisonMethod(fieldData.condition!.field),
                    value: value.trim(),
                  );
                },
              ),
            ),
          ],
        );
      default:
        return null;
    }
  }

  ComparisonMethodEnum _getDefaultComparisonMethod(
    AssetSearchMetadataFieldEnum field,
  ) {
    if ([
      AssetSearchMetadataFieldEnum.creditLocation,
      AssetSearchMetadataFieldEnum.daletID,
      AssetSearchMetadataFieldEnum.rights,
    ].contains(field)) {
      return ComparisonMethodEnum.equal;
    } else {
      return ComparisonMethodEnum.contains;
    }
  }

  dynamic _getDefaultValue(
    AssetSearchMetadataFieldEnum field,
  ) {
    if ([
      AssetSearchMetadataFieldEnum.credit,
      AssetSearchMetadataFieldEnum.headline,
      AssetSearchMetadataFieldEnum.originalFileName,
      AssetSearchMetadataFieldEnum.qcNotes,
      AssetSearchMetadataFieldEnum.rightsDetails,
      AssetSearchMetadataFieldEnum.rightsInstructions,
      AssetSearchMetadataFieldEnum.shotDescription,
    ].contains(field)) {
      return '';
    } else {
      return null;
    }
  }
}

class _InputFieldData {
  UniqueKey key = UniqueKey();
  final focusNode = FocusNode();

  AssetSearchDataMetadataConditionModel? condition;

  _InputFieldData({
    this.condition,
  });
}
