/// A widget that displays a grid view of assets.
///
/// This widget shows a collection of cards, each representing an asset with
/// an image and associated metadata. It is designed to be used within the
/// context of an asset management application.
library;
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/utils/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/models/assets_grid_view_panel_model.dart';
export 'package:tmz_mam_flutter/models/assets_grid_view_panel_model.dart';

class AssetsGridViewPanelWidget extends StatefulWidget {
  const AssetsGridViewPanelWidget({super.key});

  @override
  State<AssetsGridViewPanelWidget> createState() =>
      _AssetsGridViewPanelWidgetState();
}

/// The state class for [AssetsGridViewPanelWidget].
///
/// This class manages the state for the grid view of assets, including the
/// fetching of asset data and handling user interactions.
class _AssetsGridViewPanelWidgetState extends State<AssetsGridViewPanelWidget> {
  late AssetsGridViewPanelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the model with a context and a factory method.
    _model = createModel(context, () => AssetsGridViewPanelModel());
  }

  @override
  void dispose() {
    // Dispose of the model if necessary.
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        scrollDirection: Axis.vertical,
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/645/600',
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Close Up of a Lion\'s Face',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).darkThemeShadowColor,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Celebrity',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Shot Description',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Rights Summary',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 10.0),
                      child: Text(
                        'Hello World',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Credit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Hello World',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
