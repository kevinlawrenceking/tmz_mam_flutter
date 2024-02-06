import 'package:tmz_mam_flutter/components/admin_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/utils/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/components/admin_widget.dart' show AdminWidget;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
    adminPageControlBarModel =
        createModel(context, () => AdminPageControlBarModel());
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    searchBarModel.dispose();
    adminPageControlBarModel.dispose();
    tabBarController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
