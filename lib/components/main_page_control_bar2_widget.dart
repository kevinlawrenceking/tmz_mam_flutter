import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../flutter_flow_theme.dart';
import 'main_page_control_bar2_model.dart';
import 'actions_drop_down_menu_assets_widget.dart';
import 'package:url_launcher/url_launcher.dart';
 
class MainPageControlBar2Widget extends StatefulWidget {
  final Function(int)? updateLimitCallback;
  final int totalRecords; // Add this line

  const MainPageControlBar2Widget({
    Key? key,
    this.updateLimitCallback,
    this.totalRecords = 33, // Make it optional with a default value of 0
  }) : super(key: key);

  @override
  _MainPageControlBar2WidgetState createState() =>
      _MainPageControlBar2WidgetState();
}


class _MainPageControlBar2WidgetState extends State<MainPageControlBar2Widget> {
  late MainPageControlBar2Model _model;
  String? dropDownValue = '50'; // Default value

    int limit = 10; // Number of items per page
  int offset = 0; // Starting offset

  @override
  void initState() {
    super.initState();
    _model = MainPageControlBar2Model();
    // Initialize your model here if necessary
  }

  @override
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
          child: Text(
            'Assets (${widget.totalRecords})',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
     
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ActionsDropDownMenuAssetsWidget();
              },
            );
          },
          child: FaIcon(
            FontAwesomeIcons.ellipsis,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24.0,
          ),
        ),
        
           Spacer(),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Results per page:',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(width: 10),
              DropdownButton<int>(
                value: limit,
                icon: Icon(Icons.keyboard_arrow_down),
                onChanged: (newLimit) {
                  if (newLimit != null) {
                    setState(() {
                      limit = newLimit;
                    });
                    if (widget.updateLimitCallback != null) {
                      widget.updateLimitCallback!(newLimit);
                    }
                  }
                },
                items: [10, 25, 50, 100, 250, 500].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_left_sharp, color: FlutterFlowTheme.of(context).primaryText, size: 32.0),
              SizedBox(width: 10),
              Icon(Icons.arrow_right_sharp, color: FlutterFlowTheme.of(context).primaryText, size: 32.0),
              SizedBox(width: 10),
              Text(
                '1 of 500', // You might want to make this dynamic based on the actual pagination
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
    ),
  );
}
 
}
