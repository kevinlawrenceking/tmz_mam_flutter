import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/picklist_agency.dart';
import 'package:tmz_damz/features/asset_import/bloc/metadata_bloc.dart';
import 'package:tmz_damz/features/asset_import/widgets/tag_field.dart';

class PicklistAgencyTagField extends StatefulWidget {
  final FocusNode? focusNode;
  final bool enabled;
  final List<String> tags;
  final void Function(List<String> tags) onChange;

  const PicklistAgencyTagField({
    super.key,
    this.focusNode,
    this.enabled = true,
    required this.tags,
    required this.onChange,
  });

  @override
  State<PicklistAgencyTagField> createState() => _PicklistAgencyTagFieldState();
}

class _PicklistAgencyTagFieldState extends State<PicklistAgencyTagField> {
  final _fieldKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<MetadataBloc>(),
      child: BlocBuilder<MetadataBloc, MetadataBlocState>(
        buildWhen: (_, state) => state is AgencyPicklistState,
        builder: (context, state) {
          List<PicklistAgencyModel> picklist;

          if (state is AgencyPicklistState) {
            picklist = state.picklist;
          } else {
            picklist = [];
          }

          return TagField<String>(
            fieldKey: _fieldKey,
            focusNode: widget.focusNode,
            enabled: widget.enabled,
            hintText: 'Add agency...',
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
                RetrieveAgencyPicklistEvent(
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
