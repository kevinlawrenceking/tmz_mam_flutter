import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/sources/picklist_agency.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/tag_field.dart';
import 'package:tmz_damz/utils/debounce_timer.dart';

class PicklistAgencyTagField extends StatefulWidget {
  final bool enabled;
  final bool canAddNewtags;
  final List<String> tags;
  final void Function(List<String> tags) onChange;

  const PicklistAgencyTagField({
    super.key,
    this.enabled = true,
    required this.canAddNewtags,
    required this.tags,
    required this.onChange,
  });

  @override
  State<PicklistAgencyTagField> createState() => _PicklistAgencyTagFieldState();
}

class _PicklistAgencyTagFieldState extends State<PicklistAgencyTagField> {
  final _agencyDataSource = GetIt.instance<IPicklistAgencyDataSource>();
  final _debounce = DebounceTimer();

  List<String>? _suggestions;

  @override
  Widget build(BuildContext context) {
    return TagField<String>(
      enabled: widget.enabled,
      canAddNewtags: widget.canAddNewtags,
      hintText: 'Add agency...',
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
          final result = await _agencyDataSource.getAgencyList(
            searchTerm: query,
            offset: 0,
            limit: 100,
          );

          setState(() {
            _suggestions = result.fold(
              (failure) => null,
              (result) => result.agencies.map((_) => _.name).toList(),
            );
          });
        });
      },
    );
  }
}
