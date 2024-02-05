
import 'package:tmz_mam_flutter/flutter_flow/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/controllers/form_field_controller.dart';
import 'package:tmz_mam_flutter/components/collection_page_control_bar_widget.dart'
    show CollectionPageControlBarWidget;
import 'package:flutter/material.dart';

class CollectionPageControlBarModel
    extends FlutterFlowModel<CollectionPageControlBarWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for sortByFields widget.
  String? sortByFieldsValue;
  FormFieldController<String>? sortByFieldsValueController;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
