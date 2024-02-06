// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/themes/flutter_flow_theme.dart'; // Make sure this import points to the correct file location

class MetadataUpdateFormWidget extends StatefulWidget {
  const MetadataUpdateFormWidget({super.key});

  @override
  MetadataUpdateFormWidgetState createState() =>
      MetadataUpdateFormWidgetState();
}

class MetadataUpdateFormWidgetState extends State<MetadataUpdateFormWidget> {
  // Initialize your controllers and focus nodes here

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context); // Access FlutterFlowTheme

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: theme.primaryBackground, // Use a color from FlutterFlowTheme
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildFormCard(theme),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, FlutterFlowTheme theme) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        // Here's where you adjust the padding inside the text field
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      style: theme.bodyMedium, // Use your theme's body text style here
    );
  }

  Widget buildFormCard(FlutterFlowTheme theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Update Metadata',
                style: theme.title3.override(
                    fontFamily:
                        'Open Sans')), // Adjust the style to match your needs
            const SizedBox(height: 10),
            buildTextField('Headline', 'Insert Text ...', theme),
            const SizedBox(
                height:
                    16), // Added space between the headline text field and the dropdown
            buildDropDown(
                'Celebrity', ['Admin', 'Manager', 'Editor', 'Viewer'], theme),
            const SizedBox(
                height:
                    16), // Adjusted space between the dropdown and the next text field
            buildTextField('Celebrity Alternate', 'Insert Text...', theme),
            // Add more form fields as needed
            buildActionButtons(theme),
          ],
        ),
      ),
    );
  }

  Widget buildDropDown(
      String label, List<String> options, FlutterFlowTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(label,
              style: theme.bodyMedium.override(
                  fontFamily:
                      'Roboto')), // Adjust the style to match your needs
        ),
        DropdownButtonFormField<String>(
          items: options
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          decoration: InputDecoration(
            fillColor: theme
                .secondaryBackground, // Adjust according to FlutterFlowTheme
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget buildActionButtons(FlutterFlowTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () =>
              Navigator.pop(context), // Adjust the style to match your needs
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: theme.secondary)),
            backgroundColor: theme.secondaryBackground,
          ),
          child: Text('Cancel',
              style: theme.subtitle2.override(fontFamily: 'Roboto')),
        ),
        ElevatedButton(
          onPressed: () {
            // Save changes logic
          }, // Adjust the style to match your needs
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: theme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('Save Changes',
              style: theme.subtitle2.override(fontFamily: 'Roboto')),
        ),
      ],
    );
  }
}
