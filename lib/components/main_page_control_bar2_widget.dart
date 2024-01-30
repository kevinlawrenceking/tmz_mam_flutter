import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../flutter_flow_theme.dart';
import 'main_page_control_bar2_model.dart';
import 'actions_drop_down_menu_assets_widget.dart';

class MainPageControlBar2Widget extends StatefulWidget {
  const MainPageControlBar2Widget({Key? key}) : super(key: key);

  @override
  _MainPageControlBar2WidgetState createState() => _MainPageControlBar2WidgetState();
}

class _MainPageControlBar2WidgetState extends State<MainPageControlBar2Widget> {
  late MainPageControlBar2Model _model;
  String? dropDownValue = '50'; // Default value

  @override
  void initState() {
    super.initState();
    _model = MainPageControlBar2Model();
    // Initialize your model here if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 20.0),
          child: Text(
            'Assets (1242329)',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ActionsDropDownMenuAssetsWidget();
              },
            );
          },
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
            child: FaIcon(
              FontAwesomeIcons.ellipsis,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Results per page',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: dropDownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue;
                  });
                },
                items: <String>['25', '50', '100', '150', '300', '500']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_left_sharp, color: FlutterFlowTheme.of(context).primaryText, size: 32.0),
              SizedBox(width: 10),
              Icon(Icons.arrow_right_sharp, color: FlutterFlowTheme.of(context).primaryText, size: 32.0),
              SizedBox(width: 10),
              Text(
                '1 of 500',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
