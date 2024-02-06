
import 'package:tmz_mam_flutter/components/main_page_control_bar_widget.dart';
import '/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/utils/flutter_flow_util.dart';
import '../components/home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'main_page_control_bar2_model.dart';


class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for searchBar component.
  late SearchBarModel searchBarModel;
  // Model for mainPageControlBar component.
  late MainPageControlBarModel mainPageControlBarModel;
  // Model for mainPageControlBar2 component.
  late MainPageControlBar2Model mainPageControlBar2Model;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
    mainPageControlBarModel =
        createModel(context, () => MainPageControlBarModel());
    mainPageControlBar2Model =
        createModel(context, () => MainPageControlBar2Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    searchBarModel.dispose();
    mainPageControlBarModel.dispose();
    mainPageControlBar2Model.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
