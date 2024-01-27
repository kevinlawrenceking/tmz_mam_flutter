import '/components/media_page_control_bar_widget.dart';
import '/components/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';

import 'media_page_widget.dart' show MediaPageWidget;
import 'package:flutter/material.dart';

// Assuming 'Inventory' is the correct model class you're using
import '/inventory.dart';

class MediaPageModel extends FlutterFlowModel<MediaPageWidget> {
  /// State fields for stateful widgets in this page.

  final FocusNode unfocusNode = FocusNode();
  // Model for searchBar component.
  late SearchBarModel searchBarModel;
  // Model for mediaPageControlBar component.
  late MediaPageControlBarModel mediaPageControlBarModel;

  final int id;
  final Inventory inventoryItem;

  MediaPageModel(this.id, this.inventoryItem);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
    mediaPageControlBarModel =
        createModel(context, () => MediaPageControlBarModel());
    // You might want to use id and inventoryItem here for initialization
  }

  void dispose() {
    unfocusNode.dispose();
    searchBarModel.dispose();
    mediaPageControlBarModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
