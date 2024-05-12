import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/sources/collection.dart';

class CollectionAutocompleteField extends StatefulWidget {
  final void Function(CollectionModel? model) onSelectionChanged;

  const CollectionAutocompleteField({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<CollectionAutocompleteField> createState() =>
      _CollectionAutocompleteFieldState();
}

class _CollectionAutocompleteFieldState
    extends State<CollectionAutocompleteField> {
  final _collectionDataSource = GetIt.instance<ICollectionDataSource>();
  final _searchController = TextEditingController();

  var _collections = <CollectionModel>[];
  String? _searchTerm;

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropDownSearchFormField(
      onSuggestionSelected: (suggestion) {
        _searchController.text = suggestion.name;

        widget.onSelectionChanged(suggestion);

        setState(() {});
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(itemData.name),
        );
      },
      loadingBuilder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 10.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey.shade800,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      height: 32.0,
                      width: 32.0,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      suggestionsCallback: (pattern) async {
        _searchTerm = pattern;

        final result = await _collectionDataSource.getCollectionList(
          searchTerm: _searchTerm,
          offset: 0,
          limit: 50,
        );

        if (_searchTerm != pattern) {
          return _collections;
        }

        return result.fold(
          (_) => _collections,
          (results) => _collections = results.collections,
        );
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        clipBehavior: Clip.antiAlias,
        color: Colors.grey.shade800,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        controller: _searchController,
        decoration: const InputDecoration(),
      ),
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
    );
  }
}
