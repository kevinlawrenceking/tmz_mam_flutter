// ignore_for_file: deprecated_member_use_from_same_package, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_damz/models/admin_page_control_bar_model.dart';
import 'package:tmz_damz/themes/flutter_flow_theme.dart';
import 'package:tmz_damz/utils/flutter_flow_util.dart';

/// A widget used in the admin section of the TMZ Media Asset Manager to provide control options.
///
/// This widget displays a control bar at the top of the admin page, allowing administrators
/// to access various administrative functionalities such as navigating through menu options
/// and viewing the number of users. It's designed to enhance the admin user experience
/// by providing quick access to common tasks.
export 'package:tmz_damz/models/admin_page_control_bar_model.dart';

class AdminPageControlBarWidget extends StatefulWidget {
  const AdminPageControlBarWidget({super.key});

  @override
  AdminPageControlBarWidgetState createState() =>
      AdminPageControlBarWidgetState();
}

class AdminPageControlBarWidgetState extends State<AdminPageControlBarWidget> {
  late AdminPageControlBarModel _model;

  @override
  void initState() {
    super.initState();
    // Initialize the AdminPageControlBarModel.
    _model = createModel(context, () => AdminPageControlBarModel());
  }

  @override
  void dispose() {
    // Dispose of the model to clean up resources when the widget is removed from the widget tree.
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build the admin control bar UI.
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
      child: Container(
        width: 1463.0,
        height: 48.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
        ),
        child: Stack(
          children: [
            // Menu icon and user count display.
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Icon(
                      Icons.menu_sharp,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Users (4)',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                            ),
                          ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          5.0, 0.0, 0.0, 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.ellipsis,
                        color:
                            FlutterFlowTheme.of(context).darkThemeShadowColor,
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
