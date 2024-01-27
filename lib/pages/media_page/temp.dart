import '/components/media_page_control_bar_widget.dart';
import '/components/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'media_page_model.dart';
export 'media_page_model.dart';

// Assuming 'Inventory' is the correct model class you're using
import '/inventory.dart';

class MediaPageWidget extends StatefulWidget {
  final int id;
  final Inventory inventoryItem;

  const MediaPageWidget({
    Key? key,
    required this.id,
    required this.inventoryItem,
  }) : super(key: key);

  @override
  _MediaPageWidgetState createState() => _MediaPageWidgetState();
}

class _MediaPageWidgetState extends State<MediaPageWidget> {
  late MediaPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediaPageModel(widget.id, widget.inventoryItem));
  }

  @override
  void dispose() {
    _model.dispose();
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                FFIcons.ktmzLogo1,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                context.pop();
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: wrapWithModel(
                  model: _model.searchBarModel,
                  updateCallback: () => setState(() {}),
                  child: SearchBarWidget(),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                child: wrapWithModel(
                  model: _model.mediaPageControlBarModel,
                  updateCallback: () => setState(() {}),
                  child: MediaPageControlBarWidget(),
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
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                      child: Text(
                        'Tall Grass Blowing in the Wind',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).headlineLarge,
                      ),
                    ),
                  ),
                                    Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 20, 0),
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
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'Appers In: Collection 1, Collection 36',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 0, 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://picsum.photos/seed/725/600',
                                        width: 600,
                                        height: 400,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        100, 0, 20, 0),
                                    child: Container(
                                      width: 673,
                                      height: 435,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Your additional widget children go here
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                    width: 1490,
                    height: 64,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Your Row children for displaying content
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

