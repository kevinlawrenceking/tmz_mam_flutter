import '/backend/api_requests/api_calls.dart';
import '/components/admin_page_control_bar_widget.dart';
import '/components/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'admin_widget.dart' show AdminWidget;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminModel extends FlutterFlowModel<AdminWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for searchBar component.
  late SearchBarModel searchBarModel;
  // Model for adminPageControlBar component.
  late AdminPageControlBarModel adminPageControlBarModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
    adminPageControlBarModel =
        createModel(context, () => AdminPageControlBarModel());
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
  }

  void dispose() {
    unfocusNode.dispose();
    searchBarModel.dispose();
    adminPageControlBarModel.dispose();
    tabBarController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
