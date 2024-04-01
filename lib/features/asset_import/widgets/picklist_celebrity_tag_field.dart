import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/picklist_celebrity.dart';
import 'package:tmz_damz/features/asset_import/bloc/metadata_bloc.dart';
import 'package:tmz_damz/features/asset_import/widgets/tag_field.dart';

class PicklistCelebrityTagField extends StatefulWidget {
  final FocusNode? focusNode;
  final bool enabled;
  final List<String> tags;
  final void Function(List<String> tags) onChange;

  const PicklistCelebrityTagField({
    super.key,
    this.focusNode,
    this.enabled = true,
    required this.tags,
    required this.onChange,
  });

  @override
  State<PicklistCelebrityTagField> createState() =>
      _PicklistCelebrityTagFieldState();
}

class _PicklistCelebrityTagFieldState extends State<PicklistCelebrityTagField> {
  final _fieldKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<MetadataBloc>(),
      child: BlocBuilder<MetadataBloc, MetadataBlocState>(
        buildWhen: (_, state) => state is CelebrityPicklistState,
        builder: (context, state) {
          List<PicklistCelebrityModel> picklist;

          if (state is CelebrityPicklistState) {
            picklist = state.picklist;
          } else {
            picklist = [];
          }

          return TagField<String>(
            fieldKey: _fieldKey,
            focusNode: widget.focusNode,
            enabled: widget.enabled,
            hintText: 'Add celebrity...',
            tags: widget.tags,
            suggestions: picklist.map((_) => _.name).toList(),
            labelProvider: (tag) {
              return tag;
            },
            tagProvider: (value) {
              return value;
            },
            onChange: widget.onChange,
            onSearchTextChanged: (query) {
              BlocProvider.of<MetadataBloc>(context).add(
                RetrieveCelebrityPicklistEvent(
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
