import 'package:flutter/material.dart';
import 'package:tmz_damz/models/configure_view_window_model.dart';
import 'package:tmz_damz/themes/flutter_flow_theme.dart';
import 'package:tmz_damz/utils/flutter_flow_util.dart';

export 'package:tmz_damz/models/configure_view_window_model.dart';

class ConfigureViewWindowWidget extends StatefulWidget {
  const ConfigureViewWindowWidget({super.key});

  @override
  ConfigureViewWindowWidgetState createState() =>
      ConfigureViewWindowWidgetState();
}

class ConfigureViewWindowWidgetState extends State<ConfigureViewWindowWidget> {
  late ConfigureViewWindowModel model;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    model = createModel(context, () => ConfigureViewWindowModel());
  }

  @override
  void dispose() {
    model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 900.0,
          height: 700.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 2.0),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 50.0, 0.0),
                child: Container(
                  width: 350.0,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor: FlutterFlowTheme.of(context).secondary,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 0.0),
                child: Container(
                  width: 350.0,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.arrow_back_ios,
                            size: 20.0,
                          ),
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.arrow_back_ios,
                            size: 20.0,
                          ),
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.arrow_back_ios,
                            size: 20.0,
                          ),
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.arrow_back_ios,
                            size: 20.0,
                          ),
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.arrow_back_ios,
                            size: 20.0,
                          ),
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.arrow_back_ios,
                            size: 20.0,
                          ),
                          title: Text(
                            'Title',
                            style: FlutterFlowTheme.of(context).titleLarge,
                          ),
                          tileColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          dense: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
