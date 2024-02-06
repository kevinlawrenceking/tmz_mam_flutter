import 'package:tmz_mam_flutter/components/flutter_flow_drop_down.dart';
import 'package:tmz_mam_flutter/components/flutter_flow_icon_button.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/utils/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/controllers/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/models/collection_page_control_bar_model.dart';
export 'package:tmz_mam_flutter/models/collection_page_control_bar_model.dart';

/// CollectionPageControlBarWidget is a control bar designed for the collection
/// page, providing various functionalities to enhance user interaction and
/// navigation within the collection. It offers a comprehensive set of controls
/// including sorting, filtering, view toggling, and pagination.
///
/// Features include:
/// - Displaying the total number of assets within the collection.
/// - An ellipsis icon that potentially opens up more options or actions.
/// - A customizable sorting dropdown that allows users to sort the collection
///   by different criteria such as creation date, update date, or other metadata.
/// - View toggling icons that enable users to switch between different view
///   modes (e.g., list, grid) for the assets.
/// - A filter icon to apply specific filters to the collection.
/// - Pagination controls including a dropdown to select the number of results
///   per page and arrow icons for navigating through pages.
///
/// This widget leverages the `FlutterFlowTheme` for styling to ensure consistency
/// with the application's design system. It also uses custom Flutter Flow widgets
/// like `FlutterFlowDropDown` and `FlutterFlowIconButton` for dropdowns and
/// icon buttons, respectively, providing a cohesive and user-friendly interface.
///
/// Usage:
/// Place this widget at a suitable location within your collection page layout
/// where users can easily access and interact with the control options.

class CollectionPageControlBarWidget extends StatefulWidget {
  const CollectionPageControlBarWidget({super.key});

  @override
  State<CollectionPageControlBarWidget> createState() =>
      _CollectionPageControlBarWidgetState();
}

class _CollectionPageControlBarWidgetState
    extends State<CollectionPageControlBarWidget> {
  late CollectionPageControlBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CollectionPageControlBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: responsiveVisibility(
        context: context,
        phone: false,
        tablet: false,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Assets (118)',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyLargeFamily,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyLargeFamily),
                        ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                child: FaIcon(
                  FontAwesomeIcons.ellipsis,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 45.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).primary,
                  borderRadius: 15.0,
                  borderWidth: 2.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  icon: Icon(
                    Icons.manage_search_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () {},
                ),
              ),
              Icon(
                Icons.arrow_upward,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                child: Icon(
                  Icons.arrow_downward,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                child: FlutterFlowDropDown<String>(
                  controller: _model.sortByFieldsValueController ??=
                      FormFieldController<String>(null),
                  options: const [
                    'CreatedBy',
                    'QC Notes',
                    'Headline',
                    'Celebrity',
                    'Created',
                    'Updated'
                  ],
                  onChanged: (val) =>
                      setState(() => _model.sortByFieldsValue = val),
                  width: 125.0,
                  height: 45.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                  hintText: 'Sort By',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 2.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderWidth: 2.0,
                  borderRadius: 8.0,
                  margin: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 4.0, 16.0, 4.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ),
              Icon(
                Icons.image_outlined,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
              Icon(
                Icons.image_outlined,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 32.0,
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                child: Icon(
                  Icons.image_outlined,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 40.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                child: Icon(
                  Icons.grid_on,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                child: Icon(
                  Icons.list,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                child: Icon(
                  Icons.filter_list,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                  child: Text(
                    'Results per page',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                child: FlutterFlowDropDown<String>(
                  controller: _model.dropDownValueController ??=
                      FormFieldController<String>(
                    _model.dropDownValue ??= '50',
                  ),
                  options: const ['25', '50', '100', '150', '300', '500'],
                  onChanged: (val) =>
                      setState(() => _model.dropDownValue = val),
                  width: 75.0,
                  height: 40.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 2.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderWidth: 2.0,
                  borderRadius: 8.0,
                  margin: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 4.0, 16.0, 4.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Icon(
                    Icons.arrow_left_sharp,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                  child: Icon(
                    Icons.arrow_right_sharp,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
