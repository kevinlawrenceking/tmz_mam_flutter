import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'media_page_control_bar_model.dart';
export 'media_page_control_bar_model.dart';

class MediaPageControlBarWidget extends StatefulWidget {
  const MediaPageControlBarWidget({Key? key}) : super(key: key);

  @override
  _MediaPageControlBarWidgetState createState() =>
      _MediaPageControlBarWidgetState();
}

class _MediaPageControlBarWidgetState extends State<MediaPageControlBarWidget> {
  late MediaPageControlBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediaPageControlBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 5.0, 5.0),
          child: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 15.0,
            borderWidth: 2.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.file_download_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
          child: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 15.0,
            borderWidth: 2.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.edit_sharp,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
          child: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 15.0,
            borderWidth: 2.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.create_new_folder,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
          child: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 15.0,
            borderWidth: 2.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.delete_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ),
        FlutterFlowIconButton(
          borderColor: FlutterFlowTheme.of(context).primary,
          borderRadius: 15.0,
          borderWidth: 2.0,
          buttonSize: 40.0,
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          icon: FaIcon(
            FontAwesomeIcons.ellipsisH,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24.0,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(1.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).primary,
                      borderRadius: 15.0,
                      borderWidth: 2.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.navigate_before,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).primary,
                      borderRadius: 15.0,
                      borderWidth: 2.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.navigate_next,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).primary,
                      borderRadius: 15.0,
                      borderWidth: 2.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
