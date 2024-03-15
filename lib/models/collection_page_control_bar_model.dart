import 'package:flutter/material.dart';
import 'package:tmz_damz/components/collection_page_control_bar_widget.dart'
    show CollectionPageControlBarWidget;
import 'package:tmz_damz/controllers/form_field_controller.dart';
import 'package:tmz_damz/utils/flutter_flow_util.dart';

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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
