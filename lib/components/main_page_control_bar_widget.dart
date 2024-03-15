// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_damz/components/flutter_flow_icon_button.dart';
import 'package:tmz_damz/components/flutter_flow_widgets.dart';
import 'package:tmz_damz/controllers/form_field_controller.dart';
import 'package:tmz_damz/models/main_page_control_bar_model.dart';
import 'package:tmz_damz/themes/flutter_flow_theme.dart';
import 'package:tmz_damz/utils/flutter_flow_util.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:tmz_damz/models/main_page_control_bar_model.dart';

class MainPageControlBarWidget extends StatefulWidget {
  final Function(String sortField, bool ascending)? onSortChanged;
  const MainPageControlBarWidget({super.key, this.onSortChanged});

  @override
  State<MainPageControlBarWidget> createState() =>
      _MainPageControlBarWidgetState();
}

class _MainPageControlBarWidgetState extends State<MainPageControlBarWidget> {
  late MainPageControlBarModel _model;

  FormFieldController<String?>? sortByFieldsValueController;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainPageControlBarModel());

    // Initialize sortByFieldsValueController if it's not already initialized by the model
    sortByFieldsValueController ??= FormFieldController<String?>(null);

    // Set a default value for sortByFieldsValue if necessary
    if (_model.sortByFieldsValue == null ||
        !_dropdownValues.contains(_model.sortByFieldsValue)) {
      _model.sortByFieldsValue = 'createdBy'; // Default value
    }
  }

// Define your dropdown values to check against
  final List<String> _dropdownValues = [
    'createdBy',
    'headline',
    'dateCreated',
    'dateUpdated',
  ];

  // Define the _launchURL method here
  Future<void> _launchURL() async {
    final Uri url = Uri.parse('http://tmztools/reach/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    // Dispose of sortByFieldsValueController if necessary
    sortByFieldsValueController?.dispose();

    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            width: 100.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4.0,
                  color: Color.fromARGB(51, 73, 68, 68),
                  offset: Offset(0.0, 2.0),
                )
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 0.0, 20.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: _launchURL,
                      text: 'Upload',
                      icon: const Icon(
                        Icons.file_upload_outlined,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Color.fromARGB(116, 3, 3, 3),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 10.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).primary,
                      borderRadius: 12.0,
                      borderWidth: 2.0,
                      buttonSize: 36.0,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      icon: Icon(
                        Icons.manage_search_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 18.0,
                      ),
                      onPressed: () {
                        // Opens the drawer
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primary,
                    borderRadius: 12.0,
                    borderWidth: 1.0,
                    buttonSize: 36.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    icon: Icon(
                      Icons.star,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 18.0,
                    ),
                    onPressed: () {
                      print('SavedSearch pressed ...');
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(1.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 5.0, 0.0),
                            child: Icon(
                              Icons.arrow_downward,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0, 10.0, 20, 10),
                            child: DropdownButton<String>(
                              value: _model.sortByFieldsValue,
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _model.sortByFieldsValue = val;
                                  });
                                  bool ascending =
                                      true; // Determine this based on your UI or logic
                                  widget.onSortChanged?.call(val, ascending);
                                }
                              },
                              // Assuming 'val' contains the field name and you have a way to determine the sort direction

                              items: const [
                                DropdownMenuItem(
                                    value: 'createdBy',
                                    child: Text('Created By')),
                                DropdownMenuItem(
                                    value: 'headline', child: Text('Headline')),
                                DropdownMenuItem(
                                    value: 'dateCreated',
                                    child: Text('Created')),
                                DropdownMenuItem(
                                    value: 'dateUpdated',
                                    child: Text('Updated')),
                              ],
                              hint: const Text('Sort By'),
                            ),
                          ),
                          Icon(Icons.image_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 28),
                          Icon(Icons.image_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 32),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 45.0, 0.0),
                            child: Icon(
                              Icons.image_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 40.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 0.0),
                            child: Icon(
                              Icons.grid_on,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 32.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 45.0, 0.0),
                            child: Icon(
                              Icons.list,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 32.0,
                            ),
                          ),
                          Icon(
                            Icons.filter_list,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 32.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
