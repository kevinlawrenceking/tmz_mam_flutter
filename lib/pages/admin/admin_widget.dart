import 'package:flutter/material.dart';
import '../../flutter_flow_theme.dart';
import '/components/search_bar_widget.dart';
import '/components/admin_page_control_bar_widget.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({Key? key}) : super(key: key);

  @override
  _AdminWidgetState createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  // Mock data for the DataTable
  final List<Map<String, dynamic>> mockDataTableRecordList = [
    {
      'userName': 'JohnBoe',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchBarWidget(),
            AdminPageControlBarWidget(),
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
      ),
    );
  }
}
