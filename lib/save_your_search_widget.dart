import 'themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:google_fonts/google_fonts.dart';


import 'save_your_search_model.dart';
export 'save_your_search_model.dart';

class SaveYourSearchWidget extends StatefulWidget {
  const SaveYourSearchWidget({super.key});

  @override
  State<SaveYourSearchWidget> createState() => _SaveYourSearchWidgetState();
}

class _SaveYourSearchWidgetState extends State<SaveYourSearchWidget> {
  late SaveYourSearchModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SaveYourSearchModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 226,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: Icon(
                    Icons.star,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 24,
                  ),
                ),
                Text(
                  'Save Search',
                  style: FlutterFlowTheme.of(context).titleLarge,
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: FlutterFlowTheme.of(context).tertiary,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
              child: Text(
                'Name Your Search',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Seach Name',
                  labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(1, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 5, 0),
                child: FFButtonWidget(
                  onPressed: () {
    Navigator.of(context).pop(); // Close the modal dialog

    MotionToast.success(
      title: const Text("Success"),
      description: const Text("Your search has been saved!"),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      dismissable: true,
    ).show(context);
  },
                  text: 'Save',
                  options: FFButtonOptions(
                    height: 50,
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                        ),
                    elevation: 3,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
