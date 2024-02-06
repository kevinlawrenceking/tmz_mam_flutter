import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/utils/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/controllers/form_field_controller.dart';
import '../components/advanced_search_window_widget.dart' show AdvancedSearchWindowWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AdvancedSearchWindowModel
    extends FlutterFlowModel<AdvancedSearchWindowWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for searchBar component.
  late SearchBarModel searchBarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  DateTime? datePicked4;
  DateTime? datePicked5;
  DateTime? datePicked6;
  DateTime? datePicked7;
  DateTime? datePicked8;
  DateTime? datePicked9;
  DateTime? datePicked10;
  DateTime? datePicked11;
  DateTime? datePicked12;
  DateTime? datePicked13;
  DateTime? datePicked14;
  DateTime? datePicked15;
  DateTime? datePicked16;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
  // State field(s) for DropDown widget.
  String? dropDownValue5;
  FormFieldController<String>? dropDownValueController5;
  // State field(s) for DropDown widget.
  String? dropDownValue6;
  FormFieldController<String>? dropDownValueController6;
  // State field(s) for DropDown widget.
  String? dropDownValue7;
  FormFieldController<String>? dropDownValueController7;
  // State field(s) for DropDown widget.
  String? dropDownValue8;
  FormFieldController<String>? dropDownValueController8;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
  }

  @override
  void dispose() {
    searchBarModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
