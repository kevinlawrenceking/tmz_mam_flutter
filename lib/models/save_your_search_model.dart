import 'package:flutter/material.dart';
import 'package:tmz_damz/components/save_your_search_widget.dart'
    show SaveYourSearchWidget;
import 'package:tmz_damz/utils/flutter_flow_util.dart';

class SaveYourSearchModel extends FlutterFlowModel<SaveYourSearchWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
