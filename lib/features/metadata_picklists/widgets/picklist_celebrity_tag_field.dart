import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/sources/picklist_celebrity.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/tag_field.dart';
import 'package:tmz_damz/utils/debounce_timer.dart';

class PicklistCelebrityTagField extends StatefulWidget {
  final bool enabled;
  final bool canAddNewtags;
  final List<String> tags;
  final void Function(List<String> tags) onChange;

  const PicklistCelebrityTagField({
    super.key,
    this.enabled = true,
    required this.canAddNewtags,
    required this.tags,
    required this.onChange,
  });

  @override
  State<PicklistCelebrityTagField> createState() =>
      _PicklistCelebrityTagFieldState();
}

class _PicklistCelebrityTagFieldState extends State<PicklistCelebrityTagField> {
  final _celebrityDataSource = GetIt.instance<IPicklistCelebrityDataSource>();
  final _debounce = DebounceTimer();

  List<String>? _suggestions;

  @override
  Widget build(BuildContext context) {
    return TagField<String>(
      enabled: widget.enabled,
      canAddNewtags: widget.canAddNewtags,
      hintText: 'Add celebrity...',
      tags: widget.tags,
      suggestions: _suggestions ?? [],
      labelProvider: (tag) {
        return tag;
      },
      valueProvider: (tag) {
        return tag;
      },
      onChange: (tags) {
        setState(() {
          _suggestions = null;
        });

        widget.onChange(tags);
      },
      onSearchTextChanged: (query) {
        _debounce.wrap(() async {
          final result = await _celebrityDataSource.getCelebrityList(
            searchTerm: query,
            offset: 0,
            limit: 100,
          );

          setState(() {
            _suggestions = result.fold(
              (failure) => null,
              (result) => result.celebrities.map((_) => _.name).toList(),
            );
          });
        });
      },
    );
  }
}
