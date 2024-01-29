// admin_page.dart
import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/components/custom_app_bar.dart';
import 'package:tmz_mam_flutter/components/search_bar_widget.dart';
import 'package:tmz_mam_flutter/components/media_page_control_bar_widget.dart';
import 'package:tmz_mam_flutter/components/bottom_buttons_widget.dart';
import 'package:tmz_mam_flutter/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockDataTableRecordList = [
      {
        'userName': 'JohnDoe',
        'email': 'john.doe@example.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'enabled': 'true',
        'roles': 'Admin',
      },
      {
        'userName': 'JaneSmith',
        'email': 'jane.smith@example.com',
        'firstName': 'Jane',
        'lastName': 'Smith',
        'enabled': 'false',
        'roles': 'User',
      },
      // Add more mock records as needed
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Admin',
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              // Implement theme toggle functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarWidget(), // Search bar component
          MediaPageControlBarWidget(), // Toolbar component

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              thickness: 1,
              indent: 8,
              endIndent: 8,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
          ),

          Expanded(
            child: DataTable(
              columns: [
                DataColumn(label: Text('User Name')),
                DataColumn(label: Text('Email Address')),
                DataColumn(label: Text('First Name')),
                DataColumn(label: Text('Last Name')),
                DataColumn(label: Text('Enabled')),
                DataColumn(label: Text('Roles')),
              ],
              rows: mockDataTableRecordList.map((record) => DataRow(cells: [
                DataCell(Text(record['userName'] ?? '')),
                DataCell(Text(record['email'] ?? '')),
                DataCell(Text(record['firstName'] ?? '')),
                DataCell(Text(record['lastName'] ?? '')),
                DataCell(Text(record['enabled'] ?? '')),
                DataCell(Text(record['roles'] ?? '')),
              ])).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonsWidget(),
    );
  }
}