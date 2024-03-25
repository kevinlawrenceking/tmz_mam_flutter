import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class AddAssetsToCollection extends StatefulWidget {
  final ThemeData theme;
  final VoidCallback onCancel;
  final void Function(String collectionID) onConfirm;

  const AddAssetsToCollection({
    super.key,
    required this.theme,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<AddAssetsToCollection> createState() => _AddAssetsToCollectionState();
}

class _AddAssetsToCollectionState extends State<AddAssetsToCollection> {
  late TextEditingController _editingController;
  var _collections = <CollectionModel>[];
  String? _searchTerm;
  CollectionModel? _selectedCollection;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1D1E1F),
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: kElevationToShadow[24],
        color: const Color(0xFF232323),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            color: const Color(0xFF1D1E1F),
            child: Text(
              'Add assets to collection...',
              style: widget.theme.textTheme.titleSmall?.copyWith(
                color: Colors.blue,
                letterSpacing: 1.0,
              ),
              softWrap: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: 20.0,
              bottom: 10.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Name',
                      style: widget.theme.textTheme.bodySmall,
                      softWrap: false,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Autocomplete<CollectionModel>(
                        onSelected: (option) {
                          _selectedCollection = option;
                        },
                        displayStringForOption: (option) {
                          return option.name;
                        },
                        fieldViewBuilder: (
                          context,
                          textEditingController,
                          focusNode,
                          onFieldSubmitted,
                        ) {
                          _editingController = textEditingController;

                          return TextFormField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            onFieldSubmitted: (value) {
                              onFieldSubmitted();
                            },
                          );
                        },
                        optionsBuilder: (textEditingValue) async {
                          _searchTerm = textEditingValue.text;

                          final ds = GetIt.instance<ICollectionDataSource>();

                          final result = await ds.getCollectionList(
                            searchTerm: _searchTerm,
                            offset: 0,
                            limit: 50,
                          );

                          if (_searchTerm != textEditingValue.text) {
                            return _collections;
                          }

                          return result.fold(
                            (_) => _collections,
                            (results) => _collections = results.collections,
                          );
                        },
                        optionsViewBuilder: _optionsBuilder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: 100.0,
                  child: TextButton(
                    onPressed: () => widget.onCancel(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0x30FFFFFF),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 6.0,
                        ),
                      ),
                      shape: MaterialStateProperty.resolveWith(
                        (states) {
                          return RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0x80000000),
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          );
                        },
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Text(
                        'Cancel',
                        style: widget.theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 100.0,
                  child: TextButton(
                    onPressed: () {
                      if (_editingController.text ==
                          _selectedCollection?.name) {
                        widget.onConfirm(_selectedCollection!.id);
                      } else {
                        Toast.showNotification(
                          showDuration: const Duration(seconds: 5),
                          type: ToastTypeEnum.information,
                          message: 'You must select a collection.',
                        );
                      }
                    },
                    style: widget.theme.textButtonTheme.style,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Text(
                        'Add',
                        style: widget.theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionsBuilder(
    BuildContext context,
    AutocompleteOnSelected<CollectionModel> onSelected,
    Iterable<CollectionModel> options,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: SizedBox(
          width: 400.0,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);

              return InkWell(
                onTap: () => onSelected(option),
                child: Builder(
                  builder: (context) {
                    final highlight =
                        AutocompleteHighlightedOption.of(context) == index;

                    if (highlight) {
                      SchedulerBinding.instance.addPostFrameCallback(
                        (timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        },
                      );
                    }

                    return Container(
                      color: highlight ? Theme.of(context).focusColor : null,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(option.name),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
