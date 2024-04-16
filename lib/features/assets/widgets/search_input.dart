import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/shared/widgets/editable_text_context_menu_builder.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final void Function() onClear;
  final void Function(String value) onFieldSubmitted;

  const SearchInput({
    super.key,
    required this.controller,
    required this.onClear,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final undoController = UndoHistoryController();

    return TextFormField(
      controller: controller,
      undoController: undoController,
      contextMenuBuilder: (context, editableTextState) =>
          kEditableTextContextMenuBuilder(
        context,
        editableTextState,
        undoController,
      ),
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
          onPressed: onClear,
        ),
      ),
      style: const TextStyle(
        color: Color(0xDEFFFFFF),
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
