import 'package:flutter/material.dart';
import 'package:tmz_damz/components/main_page_control_bar_widget.dart'
    show MainPageControlBarWidget;
import 'package:tmz_damz/controllers/form_field_controller.dart';
import 'package:tmz_damz/utils/flutter_flow_util.dart';

class MainPageControlBarModel
    extends FlutterFlowModel<MainPageControlBarWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for sortByFields widget.
  String? sortByFieldsValue;
  FormFieldController<String>? sortByFieldsValueController;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
