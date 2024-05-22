import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/picklist_keyword.dart';
import 'package:tmz_damz/features/metadata_picklists/bloc/bloc.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/tag_field.dart';

class PicklistKeywordTagField extends StatefulWidget {
  final FocusNode? focusNode;
  final bool enabled;
  final List<String> tags;
  final void Function(List<String> tags) onChange;

  const PicklistKeywordTagField({
    super.key,
    this.focusNode,
    this.enabled = true,
    required this.tags,
    required this.onChange,
  });

  @override
  State<PicklistKeywordTagField> createState() =>
      _PicklistKeywordTagFieldState();
}

class _PicklistKeywordTagFieldState extends State<PicklistKeywordTagField> {
  final _fieldKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<MetadataBloc>(),
      child: BlocBuilder<MetadataBloc, MetadataBlocState>(
        buildWhen: (_, state) => state is KeywordPicklistState,
        builder: (context, state) {
          List<PicklistKeywordModel> picklist;

          if (state is KeywordPicklistState) {
            picklist = state.picklist;
          } else {
            picklist = [];
          }

          return TagField<String>(
            fieldKey: _fieldKey,
            focusNode: widget.focusNode,
            enabled: widget.enabled,
            hintText: 'Add keyword...',
            tags: widget.tags,
            suggestions: picklist.map((_) => _.value).toList(),
            labelProvider: (tag) {
              return tag;
            },
            tagProvider: (value) {
              return value;
            },
            onChange: widget.onChange,
            onSearchTextChanged: (query) {
              BlocProvider.of<MetadataBloc>(context).add(
                RetrieveKeywordPicklistEvent(
                  searchTerm: query,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
