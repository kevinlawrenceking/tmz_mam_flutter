import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/user.dart';
import 'package:tmz_damz/features/metadata_picklists/bloc/bloc.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/tag_field.dart';
import 'package:tmz_damz/utils/debounce_timer.dart';

class PicklistUserTagField extends StatefulWidget {
  final FocusNode? focusNode;
  final bool enabled;
  final List<UserMetaModel> tags;
  final void Function(List<UserMetaModel> tags) onChange;

  const PicklistUserTagField({
    super.key,
    this.focusNode,
    this.enabled = true,
    required this.tags,
    required this.onChange,
  });

  @override
  State<PicklistUserTagField> createState() => _PicklistUserTagFieldState();
}

class _PicklistUserTagFieldState extends State<PicklistUserTagField> {
  final _fieldKey = UniqueKey();

  final _debounce = DebounceTimer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<MetadataBloc>(),
      child: BlocBuilder<MetadataBloc, MetadataBlocState>(
        buildWhen: (_, state) => state is UserPicklistState,
        builder: (context, state) {
          List<UserMetaModel> picklist;

          if (state is UserPicklistState) {
            picklist = state.picklist;
          } else {
            picklist = [];
          }

          return TagField<UserMetaModel>(
            fieldKey: _fieldKey,
            focusNode: widget.focusNode,
            enabled: widget.enabled,
            canAddNewtags: false,
            hintText: 'Add user...',
            tags: widget.tags,
            suggestions: picklist,
            labelProvider: (tag) {
              return '${tag.firstName} ${tag.lastName}'.trim();
            },
            valueProvider: (tag) {
              return picklist.firstWhereOrNull(
                (_) => '${_.firstName} ${_.lastName}'.trim() == tag,
              );
            },
            onChange: widget.onChange,
            onSearchTextChanged: (query) {
              _debounce.wrap(() {
                BlocProvider.of<MetadataBloc>(context).add(
                  RetrieveUserPicklistEvent(
                    searchTerm: query,
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}
