import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/user.dart';
import 'package:tmz_damz/data/sources/user.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/tag_field.dart';
import 'package:tmz_damz/utils/debounce_timer.dart';

class PicklistUserTagField extends StatefulWidget {
  final bool enabled;
  final List<UserMetaModel> tags;
  final void Function(List<UserMetaModel> tags) onChange;

  const PicklistUserTagField({
    super.key,
    this.enabled = true,
    required this.tags,
    required this.onChange,
  });

  @override
  State<PicklistUserTagField> createState() => _PicklistUserTagFieldState();
}

class _PicklistUserTagFieldState extends State<PicklistUserTagField> {
  final _userDataSource = GetIt.instance<IUserDataSource>();
  final _debounce = DebounceTimer();

  List<UserMetaModel>? _suggestions;

  @override
  Widget build(BuildContext context) {
    return TagField<UserMetaModel>(
      enabled: widget.enabled,
      canAddNewtags: false,
      hintText: 'Add user...',
      tags: widget.tags,
      suggestions: _suggestions ?? [],
      labelProvider: (tag) {
        return '${tag.firstName} ${tag.lastName}'.trim();
      },
      valueProvider: (tag) {
        return _suggestions?.firstWhereOrNull(
          (_) => '${_.firstName} ${_.lastName}'.trim() == tag,
        );
      },
      onChange: (tags) {
        setState(() {
          _suggestions = null;
        });

        widget.onChange(tags);
      },
      onSearchTextChanged: (query) {
        _debounce.wrap(() async {
          final result = await _userDataSource.getUserList(
            searchTerm: query,
            offset: 0,
            limit: 100,
          );

          setState(() {
            _suggestions = result.fold(
              (failure) => null,
              (result) => result.users,
            );
          });
        });
      },
    );
  }
}
