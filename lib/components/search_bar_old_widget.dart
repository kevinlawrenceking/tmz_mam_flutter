import 'package:flutter/material.dart';

class SearchBarOldWidget extends StatefulWidget {
  const SearchBarOldWidget({Key? key}) : super(key: key);

  @override
  _SearchBarOldWidgetState createState() => _SearchBarOldWidgetState();
}

class _SearchBarOldWidgetState extends State<SearchBarOldWidget> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _textController,
        decoration: InputDecoration(
          labelText: 'Search ...',
          hintText: 'Type here to search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => _textController.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(),
          ),
        ),
        onFieldSubmitted: (value) {
          // Handle the search logic here if needed, or just clear the search field
          _textController.clear();
        },
      ),
    );
  }
}
