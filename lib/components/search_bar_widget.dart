import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/utils/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmz_mam_flutter/models/search_bar_model.dart';
export 'package:tmz_mam_flutter/models/search_bar_model.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late SearchBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchBarModel());

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
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 15.0),
      child: TextFormField(
        controller: _model.textController,
        focusNode: _model.textFieldFocusNode,
        autofocus: true,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Search ...',
          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                color: FlutterFlowTheme.of(context).primaryText,
                useGoogleFonts: GoogleFonts.asMap().containsKey(
                    FlutterFlowTheme.of(context).labelMediumFamily),
              ),
          hintStyle: FlutterFlowTheme.of(context).labelLarge.override(
                fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                color: FlutterFlowTheme.of(context).primaryText,
                useGoogleFonts: GoogleFonts.asMap()
                    .containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).secondaryText,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).error,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).error,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: FlutterFlowTheme.of(context).primaryBackground,
          contentPadding:
              const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 24.0),
          prefixIcon: const Icon(
            Icons.search_outlined,
          ),
          suffixIcon: const Icon(
            Icons.highlight_off_outlined,
          ),
        ),
        style: FlutterFlowTheme.of(context).bodyMedium,
        validator: _model.textControllerValidator.asValidator(context),
      ),
    );
  }
}
