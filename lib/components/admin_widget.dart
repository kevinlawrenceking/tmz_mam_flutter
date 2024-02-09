import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/components/search_bar_old_widget.dart';
import 'package:tmz_mam_flutter/components/admin_page_control_bar_widget.dart';

/// AdminWidget is a comprehensive administration interface within the application,
/// designed to allow privileged users to manage and view user-related data.
/// It features a search bar for quick filtering, a control bar for various admin actions,
/// and a data table displaying user records.
///
/// The data table in this widget is currently populated with mock data for demonstration
/// purposes, showcasing typical user information such as names, email addresses, roles,
/// and account status. This setup serves as a placeholder to be replaced or augmented with
/// dynamic data retrieval from a database or API in a production environment.
///
/// Features include:
/// - A search bar (`SearchBarWidget`) at the top for filtering user records based on specific queries.
/// - An admin page control bar (`AdminPageControlBarWidget`) providing actionable controls related
///   to user management, such as adding, editing, or deleting user accounts.
/// - A `DataTable` widget that lists user records with columns for user names, email addresses,
///   first and last names, account enabled status, and roles. This table allows for easy
///   at-a-glance management and review of user details.
///
/// Usage:
/// This widget is intended to be used as part of an admin dashboard or panel, where administrative
/// users can manage application users. It should be integrated into the application's navigation
/// structure in a way that restricts access to authorized users only.

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  @override
  AdminWidgetState createState() => AdminWidgetState();
}

class AdminWidgetState extends State<AdminWidget> {
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
        title: const Text('Admin Page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SearchBarOldWidget(),
            const AdminPageControlBarWidget(),
            Expanded(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('User Name')),
                  DataColumn(label: Text('Email Address')),
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Enabled')),
                  DataColumn(label: Text('Roles')),
                ],
                rows: mockDataTableRecordList
                    .map((record) => DataRow(cells: [
                          DataCell(Text(record['userName'] ?? '')),
                          DataCell(Text(record['email'] ?? '')),
                          DataCell(Text(record['firstName'] ?? '')),
                          DataCell(Text(record['lastName'] ?? '')),
                          DataCell(Text(record['enabled'] ?? '')),
                          DataCell(Text(record['roles'] ?? '')),
                        ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
