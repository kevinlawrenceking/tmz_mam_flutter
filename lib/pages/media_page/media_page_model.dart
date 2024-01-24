import '/components/media_page_control_bar_widget.dart';
import '/components/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'media_page_widget.dart' show MediaPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MediaPageModel extends FlutterFlowModel<MediaPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for searchBar component.
  late SearchBarModel searchBarModel;
  // Model for mediaPageControlBar component.
  late MediaPageControlBarModel mediaPageControlBarModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
    mediaPageControlBarModel =
        createModel(context, () => MediaPageControlBarModel());
  }

  void dispose() {
    unfocusNode.dispose();
    searchBarModel.dispose();
    mediaPageControlBarModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
