import '/components/main_page_control_bar2_widget.dart';
import '/components/main_page_control_bar_widget.dart';
import '/components/search_bar_widget.dart';
import '../../flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
    mainPageControlBarModel =
        createModel(context, () => MainPageControlBarModel());
    mainPageControlBar2Model =
        createModel(context, () => MainPageControlBar2Model());
  }

  void dispose() {
    unfocusNode.dispose();
    searchBarModel.dispose();
    mainPageControlBarModel.dispose();
    mainPageControlBar2Model.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
