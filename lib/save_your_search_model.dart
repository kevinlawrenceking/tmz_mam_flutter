import 'themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_widgets.dart';
import 'save_your_search_widget.dart' show SaveYourSearchWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SaveYourSearchModel extends FlutterFlowModel<SaveYourSearchWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

