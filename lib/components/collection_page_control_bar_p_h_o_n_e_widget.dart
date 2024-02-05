import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_drop_down.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_icon_button.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/controllers//form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/models/collection_page_control_bar_p_h_o_n_e_model.dart';
export 'package:tmz_mam_flutter/models/collection_page_control_bar_p_h_o_n_e_model.dart';

class CollectionPageControlBarPHONEWidget extends StatefulWidget {
  const CollectionPageControlBarPHONEWidget({super.key});

  @override
  State<CollectionPageControlBarPHONEWidget> createState() =>
      _CollectionPageControlBarPHONEWidgetState();
}

class _CollectionPageControlBarPHONEWidgetState
    extends State<CollectionPageControlBarPHONEWidget> {
  late CollectionPageControlBarPHONEModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CollectionPageControlBarPHONEModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
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
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 45.0, 0.0),
                child: FaIcon(
                  FontAwesomeIcons.ellipsis,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 45.0, 0.0),
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
                    onPressed: () {
                      print('advancedSeach pressed ...');
                    },
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
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
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                child: Icon(
                  Icons.image_outlined,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 40.0,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                child: Icon(
                  Icons.grid_on,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                child: Icon(
                  Icons.list,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                      child: Icon(
                        Icons.arrow_downward,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                      child: FlutterFlowDropDown<String>(
                        controller: _model.sortByFieldsValueController ??=
                            FormFieldController<String>(null),
                        options: [
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor: FlutterFlowTheme.of(context).alternate,
                        borderWidth: 2.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            16.0, 4.0, 16.0, 4.0),
                        hidesUnderline: true,
                        isOverButton: true,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                      child: Icon(
                        Icons.filter_list,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                child: FlutterFlowDropDown<String>(
                  controller: _model.dropDownValueController ??=
                      FormFieldController<String>(
                    _model.dropDownValue ??= '50',
                  ),
                  options: ['25', '50', '100', '150', '300', '500'],
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
                  margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Icon(
                    Icons.arrow_left_sharp,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                  child: Icon(
                    Icons.arrow_right_sharp,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
