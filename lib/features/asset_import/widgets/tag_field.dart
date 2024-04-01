import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagField<T> extends StatefulWidget {
  final Key fieldKey;
  final FocusNode? focusNode;
  final bool? enabled;
  final String hintText;
  final List<T> tags;
  final List<T> suggestions;
  final int maxTagLength;
  final String Function(T tag) labelProvider;
  final T Function(String value) tagProvider;
  final void Function(List<T> tags) onChange;
  final void Function(String query)? onSearchTextChanged;

  const TagField({
    super.key,
    required this.fieldKey,
    this.focusNode,
    this.enabled,
    required this.hintText,
    required this.tags,
    this.suggestions = const [],
    this.maxTagLength = 100,
    required this.labelProvider,
    required this.tagProvider,
    required this.onChange,
    this.onSearchTextChanged,
  });

  @override
  State<TagField<T>> createState() => _TagFieldState();
}

class _TagFieldState<T> extends State<TagField<T>> {
  late final DynamicTagController<DynamicTagData<T>> _tagController;

  final kSuggestionDecoration = SuggestionDecoration(
    border: Border.all(),
    borderRadius: BorderRadius.circular(6.0),
    color: Colors.grey.shade800,
    elevation: 10.0,
  );

  @override
  void dispose() {
    _tagController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _tagController = DynamicTagController<DynamicTagData<T>>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return TextFieldTags<DynamicTagData<T>>(
          textfieldTagsController: _tagController,
          initialTags: widget.tags.map((tag) {
            final label = widget.labelProvider(tag);
            return DynamicTagData<T>(label, tag);
          }).toList(),
          inputFieldBuilder: (context, inputFieldValues) {
            return Focus(
              skipTraversal: !(widget.enabled ?? true),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  final value = inputFieldValues.textEditingController.text
                      .replaceAll(RegExp(r'(?![\sa-zA-Z0-9]).'), '')
                      .replaceAll(RegExp(r'\s{2,}'), '')
                      .trim();

                  if (value.isEmpty) {
                    return;
                  }

                  _tagController.onTagSubmitted(
                    DynamicTagData(value, widget.tagProvider(value)),
                  );

                  final tags = _tagController.getTags
                      ?.map(
                        (_) => _.data,
                      )
                      .toList();

                  widget.onChange(tags ?? []);
                }
              },
              child: Opacity(
                opacity: (widget.enabled ?? true) ? 1.0 : 0.5,
                child: _buildInput(
                  theme: theme,
                  constraints: constraints,
                  inputFieldValues: inputFieldValues,
                  onSearchTextChanged: widget.onSearchTextChanged,
                ),
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

  Widget _buildInput({
    required ThemeData theme,
    required BoxConstraints constraints,
    required InputFieldValues<DynamicTagData<T>> inputFieldValues,
    required void Function(String query)? onSearchTextChanged,
  }) {
    return SearchField<T>(
      key: widget.fieldKey,
      controller: inputFieldValues.textEditingController,
      focusNode: widget.focusNode,
      animationDuration: const Duration(milliseconds: 150),
      autoCorrect: false,
      enabled: widget.enabled,
      maxSuggestionsInViewPort: 10,
      suggestions: widget.suggestions.map((item) {
        final label = widget.labelProvider(item);

        return SearchFieldListItem<T>(
          label,
          item: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Text(
              label,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        );
      }).toList(),
      emptyWidget: inputFieldValues.textEditingController.text.length >= 2
          ? Container(
              decoration: kSuggestionDecoration,
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Center(
                child: Text(
                  'No results...',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            )
          : const SizedBox.shrink(),
      suggestionsDecoration: kSuggestionDecoration,
      searchInputDecoration: InputDecoration(
        border: const OutlineInputBorder(),
        errorText: inputFieldValues.error,
        hintText: inputFieldValues.tags.isNotEmpty ? '' : widget.hintText,
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
                              inputFieldValues.tags.map((_) => _.data).toList(),
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
      onSearchTextChanged: (query) {
        if (onSearchTextChanged != null) {
          widget.onSearchTextChanged!(query);
        }

        return [];
      },
      onSuggestionTap: (item) {
        final tag = item.item;
        if (tag == null) {
          return;
        }

        _tagController.onTagSubmitted(
          DynamicTagData(
            widget.labelProvider(tag),
            tag,
          ),
        );

        final tags = _tagController.getTags
            ?.map(
              (_) => _.data,
            )
            .toList();

        widget.onChange(tags ?? []);

        inputFieldValues.textEditingController.text = '';

        if (onSearchTextChanged != null) {
          widget.onSearchTextChanged!('');
        }
      },
    );
  }

  Widget _buildTag({
    required ThemeData theme,
    required DynamicTagData<T> data,
    required void Function(DynamicTagData<T> data) onRemove,
    required void Function(DynamicTagData<T> data) onTap,
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
