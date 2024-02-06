// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// Import other necessary packages and widgets

import '/components/media_page_control_bar_widget.dart';
import '/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/components/flutter_flow_icon_button.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart';
import 'package:tmz_mam_flutter/utils/flutter_flow_util.dart';
import 'package:tmz_mam_flutter/models/media_page_model.dart';
export 'package:tmz_mam_flutter/models/media_page_model.dart';
import 'wireframe_layout.dart'; // Import the wireframe layout
import 'package:tmz_mam_flutter/models/inventory.dart'; // Assuming 'Inventory' is the correct model class

class MediaPageWidget extends StatefulWidget {
  final int id;
  final Inventory inventoryItem;

  const MediaPageWidget({
    super.key,
    required this.id,
    required this.inventoryItem,
  });

  @override
  MediaPageWidgetState createState() => MediaPageWidgetState();
}

class MediaPageWidgetState extends State<MediaPageWidget> {
  late MediaPageModel model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    model = createModel(
        context, () => MediaPageModel(widget.id, widget.inventoryItem));
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: const Icon(
                FFIcons.ktmzLogo1,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            'TMZ MAM',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineMediumFamily),
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
              child: Icon(
                Icons.person,
                color: FlutterFlowTheme.of(context).primaryBackground,
                size: 32,
              ),
            ),
          ],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: wrapWithModel(
                  model: model.searchBarModel,
                  updateCallback: () => setState(() {}),
                  child: const SearchBarWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                child: wrapWithModel(
                  model: model.mediaPageControlBarModel,
                  updateCallback: () => setState(() {}),
                  child: const MediaPageControlBarWidget(),
                ),
              ),
              Divider(
                thickness: 1,
                indent: 5,
                endIndent: 5,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                      child: Text(
                        'Tall Grass Blowing in the Wind',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).headlineLarge,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: const AlignmentDirectional(1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 15, 20, 0),
                        child: Text(
                          'Categories: Specials, TV',
                          style: FlutterFlowTheme.of(context).bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'Appears In: Collection 1, Collection 36',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // Check if the width is more than a certain threshold, for example 600 pixels
                    if (constraints.maxWidth > 600) {
                      // Wide layout (side by side)
                      return Row(
                        children: [
                          // Image container
                          Expanded(
                            child: SizedBox(
                              width:
                                  640, // Set maximum width for the image container
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/725/600',
                                  width:
                                      320, // Ensure the image takes the full width of the container
                                  fit: BoxFit
                                      .cover, // Cover the entire space of the container
                                ),
                              ),
                            ),
                          ),
                          // Metadata container
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      );
                    } else {
                      // Narrow layout (stacked)
                      return Column(
                        children: [
                          // Image container
                          SizedBox(
                            width:
                                320, // Set maximum width for the image container
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/725/600',
                                width:
                                    320, // Ensure the image takes the full width of the container
                                fit: BoxFit
                                    .cover, // Cover the entire space of the container
                              ),
                            ),
                          ),
                          // Metadata container
                          Container(
                              // Your metadata container code
                              ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExistingPage extends StatelessWidget {
  const ExistingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Existing Page'),
      ),
      body: const Column(
        children: <Widget>[
          // Other existing content here
          Text('Some existing content'),
          // Include the wireframe layout here
          WireframeLayout(),
          // More existing content
          Text('More existing content'),
        ],
      ),
    );
  }
}
