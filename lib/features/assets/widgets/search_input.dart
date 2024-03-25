import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String value) onFieldSubmitted;

  const SearchInput({
    super.key,
    required this.controller,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(
          Icons.search_outlined,
          color: Color(0xDEFFFFFF),
          size: 24,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            MdiIcons.close,
            color: const Color(0xDEFFFFFF),
            size: 22,
          ),
          onPressed: () {
            controller?.clear();
            onFieldSubmitted('');
          },
        ),
      ),
      style: const TextStyle(
        color: Color(0xDEFFFFFF),
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
