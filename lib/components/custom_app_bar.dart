import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'main_page_control_bar_widget.dart' show MainPageControlBarWidget;
import 'package:google_fonts/google_fonts.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  CustomAppBar({required this.title, this.actions});

@override
Widget build(BuildContext context) {
  return AppBar(
    backgroundColor: FlutterFlowTheme.of(context).primary,
    automaticallyImplyLeading: false,
    leading: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
      child: Center( // Add Center widget
        child: Icon(
          FFIcons.ktmzLogo1,
          color: FlutterFlowTheme.of(context).primaryBackground,
          size: 20,
        ),
      ),
    ),
    title: Text(
      'TMZ MAM',
      style: FlutterFlowTheme.of(context).headlineMedium.override(
          fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
          color: FlutterFlowTheme.of(context).primaryBackground,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          useGoogleFonts: GoogleFonts.asMap()
              .containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
        ),
  ),
  actions: [
    Align(
      alignment: AlignmentDirectional(1, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
        child: Icon(
          Icons.person,
          color: FlutterFlowTheme.of(context).primaryBackground,
          size: 32,
        ),
      ),
    ),
    Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
        child: Text(
          'BM',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                color: FlutterFlowTheme.of(context).primaryBackground,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                useGoogleFonts: GoogleFonts.asMap().containsKey(
                    FlutterFlowTheme.of(context).bodyLargeFamily),
              ),
        ),
      ),
    ),
  ],
  centerTitle: true,
  elevation: 2,
)
;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
