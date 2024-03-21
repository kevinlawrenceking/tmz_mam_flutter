import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagField extends StatefulWidget {
  final String hintText;
  final List<String> initialTags;
  final void Function(List<String> tags) onChange;

  const TagField({
    super.key,
    required this.hintText,
    required this.initialTags,
    required this.onChange,
  });

  @override
  State<TagField> createState() => _TagFieldState();
}

class _TagFieldState extends State<TagField> {
  late DynamicTagController<DynamicTagData<String>> _tagController;

  @override
  void dispose() {
    _tagController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _tagController = DynamicTagController<DynamicTagData<String>>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return TextFieldTags<DynamicTagData<String>>(
          textfieldTagsController: _tagController,
          initialTags: widget.initialTags
              .map((_) => DynamicTagData<String>(_, _))
              .toList(),
          inputFieldBuilder: (context, inputFieldValues) {
            return Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final tag = inputFieldValues.textEditingController.text
                      .replaceAll(RegExp(r'(?![\sa-zA-Z0-9]).'), '')
                      .replaceAll(RegExp(r'\s{2,}'), '')
                      .trim();

                  if (tag.isEmpty) {
                    return;
                  }

                  _tagController.onTagSubmitted(
                    DynamicTagData(tag, tag),
                  );

                  final tags = _tagController.getTags
                      ?.map(
                        (_) => _.data,
                      )
                      .toList();

                  widget.onChange(tags ?? []);
                }
              },
              child: TextField(
                controller: inputFieldValues.textEditingController,
                focusNode: inputFieldValues.focusNode,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: inputFieldValues.error,
                  hintText:
                      inputFieldValues.tags.isNotEmpty ? '' : widget.hintText,
                  isDense: true,
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: constraints.maxWidth - 150,
                  ),
                  prefixIcon: inputFieldValues.tags.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                            right: 5.0,
                          ),
                          child: SingleChildScrollView(
                            controller: inputFieldValues.tagScrollController,
                            padding: const EdgeInsets.only(
                              left: 3.0,
                              top: 6.0,
                              bottom: 6.0,
                            ),
                            child: Wrap(
                              runSpacing: 6.0,
                              children: [
                                ...inputFieldValues.tags.map((data) {
                                  return _buildTag(
                                    theme: theme,
                                    data: data,
                                    onRemove: (tag) {
                                      inputFieldValues.onTagRemoved(tag);
                                      widget.onChange(
                                        inputFieldValues.tags
                                            .map((_) => _.data)
                                            .toList(),
                                      );
                                    },
                                    onTap: (tag) {
                                      //
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        )
                      : null,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                onChanged: (value) {
                  final tag = value
                      .replaceAll(RegExp(r'(?![\sa-zA-Z0-9]).'), '')
                      .replaceAll(RegExp(r'\s{2,}'), '')
                      .trim();

                  if (tag.isEmpty) {
                    return;
                  }

                  _tagController.onTagChanged(
                    DynamicTagData(tag, tag),
                  );
                },
                onSubmitted: (value) {
                  final tag = value
                      .replaceAll(RegExp(r'(?![\sa-zA-Z0-9]).'), '')
                      .replaceAll(RegExp(r'\s{2,}'), '')
                      .trim();

                  if (tag.isEmpty) {
                    return;
                  }

                  _tagController.onTagSubmitted(
                    DynamicTagData(tag, tag),
                  );

                  final tags = _tagController.getTags
                      ?.map(
                        (_) => _.data,
                      )
                      .toList();

                  widget.onChange(tags ?? []);

                  inputFieldValues.focusNode.requestFocus();
                },
                onTap: () {
                  _tagController.getFocusNode?.requestFocus();
                },
              ),
            );
          },
          validator: (data) {
            final exists =
                _tagController.getTags!.any((_) => _.tag == data.tag);

            if (exists) {
              return 'Already added';
            }

            return null;
          },
        );
      },
    );
  }

  Widget _buildTag({
    required ThemeData theme,
    required DynamicTagData<String> data,
    required void Function(DynamicTagData<String> data) onRemove,
    required void Function(DynamicTagData<String> data) onTap,
  }) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Color(0xFF8E0000),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 3.0,
      ),
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 5.0,
        right: 10.0,
        bottom: 5.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            canRequestFocus: false,
            child: Text(
              data.tag,
              style: theme.textTheme.bodyMedium,
            ),
            onTap: () => onTap(data),
          ),
          const SizedBox(width: 10.0),
          InkWell(
            canRequestFocus: false,
            child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent,
              ),
              child: const Center(
                child: Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 16.0,
                ),
              ),
            ),
            onTap: () => onRemove(data),
          ),
        ],
      ),
    );
  }
}
