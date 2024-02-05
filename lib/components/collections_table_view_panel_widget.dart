import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_data_table.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/models/collections_table_view_panel_model.dart';
export 'package:tmz_mam_flutter/models/collections_table_view_panel_model.dart';

class CollectionsTableViewPanelWidget extends StatefulWidget {
  const CollectionsTableViewPanelWidget({super.key});

  @override
  State<CollectionsTableViewPanelWidget> createState() =>
      _CollectionsTableViewPanelWidgetState();
}

class _CollectionsTableViewPanelWidgetState
    extends State<CollectionsTableViewPanelWidget> {
  late CollectionsTableViewPanelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CollectionsTableViewPanelModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

@override
Widget build(BuildContext context) {
  // Use an empty list as data for the demo
  final List<Map<String, dynamic>> demoData = [];

  return FlutterFlowDataTable<dynamic>(
    controller: _model.paginatedDataTableController,
    data: demoData, // Pass the empty data list here
    columnsBuilder: (onSortChanged) => [
      DataColumn2(
        label: DefaultTextStyle.merge(
          softWrap: true,
          child: Text(
            'Name',
            style: FlutterFlowTheme.of(context).labelLarge.override(
              fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
              color: FlutterFlowTheme.of(context).primaryBackground,
              fontWeight: FontWeight.w500,
              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
            ),
          ),
        ),
      ),
      DataColumn2(
        label: DefaultTextStyle.merge(
          softWrap: true,
          child: Text(
            'Created',
              style: FlutterFlowTheme.of(context).labelLarge.override(
                    fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).labelLargeFamily),
                  ),
            ),
          ),
        ),
      ],
      dataRowBuilder:
          (item, paginatedDataTableIndex, selected, onSelectChanged) => DataRow(
        selected: selected,
        onSelectChanged: onSelectChanged,
        color: MaterialStateProperty.all(
          paginatedDataTableIndex % 2 == 0
              ? FlutterFlowTheme.of(context).secondaryBackground
              : FlutterFlowTheme.of(context).primaryBackground,
        ),
        cells: [
          Text(
            'Edit Column 1',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Text(
            'Edit Column 2',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Text(
            'Edit Column 3',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Text(
            'Edit Column 4',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Text(
            'Edit Column 5',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
        ].map((c) => DataCell(c)).toList(),
      ),
      paginated: true,
      selectable: true,
      hidePaginator: false,
      showFirstLastButtons: false,
      headingRowHeight: 56.0,
      dataRowHeight: 48.0,
      columnSpacing: 20.0,
      headingRowColor: FlutterFlowTheme.of(context).primary,
      borderRadius: BorderRadius.circular(8.0),
      addHorizontalDivider: true,
      horizontalDividerColor: FlutterFlowTheme.of(context).secondaryBackground,
      horizontalDividerThickness: 1.0,
      addVerticalDivider: false,
      checkboxUnselectedFillColor: Colors.transparent,
      checkboxSelectedFillColor: Colors.transparent,
      checkboxCheckColor: const Color(0x8A000000),
      checkboxUnselectedBorderColor: Color(0x8A000000),
      checkboxSelectedBorderColor: const Color(0x8A000000),
    );
  }
}
