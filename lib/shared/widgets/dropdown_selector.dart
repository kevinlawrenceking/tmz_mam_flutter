import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownSelector<T> extends StatefulWidget {
  final ValueNotifier<T?> _controller;

  final List<T>? items;
  final Widget Function(T item) itemBuilder;
  final void Function(T? item)? onSelectionChanged;

  final String? hintText;
  final bool hasError;
  final bool isDisabled;

  DropdownSelector({
    super.key,
    ValueNotifier<T?>? controller,
    T? initialValue,
    this.hintText,
    this.hasError = false,
    this.isDisabled = false,
    required this.items,
    required this.itemBuilder,
    this.onSelectionChanged,
  }) : _controller = controller ?? ValueNotifier<T?>(initialValue);

  @override
  State<DropdownSelector<T>> createState() => _DropdownSelectorState<T>();
}

class _DropdownSelectorState<T> extends State<DropdownSelector<T>> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    widget._controller.addListener(_onControllerChanged);

    _focusNode.addListener(_onFocusChanged);

    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onControllerChanged);

    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();

    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void _onFocusChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        focusNode: _focusNode,
        buttonStyleData: ButtonStyleData(
          height: 42.0,
          padding: const EdgeInsets.only(right: 6.0),
          decoration: BoxDecoration(
            border: widget.hasError
                ? Border.fromBorderSide(
                    theme.inputDecorationTheme.errorBorder!.borderSide,
                  )
                : Border.all(
                    color: (widget.items?.isNotEmpty ?? false) &&
                            !widget.isDisabled
                        ? (_focusNode.hasFocus
                            ? const Color(0xFFE81B1B)
                            : const Color(0xFF454647))
                        : const Color(0xFF454647),
                  ),
            borderRadius: BorderRadius.circular(6.0),
            color: const Color(0xFF1D1E1F),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.grey.shade800,
          ),
        ),
        iconStyleData: const IconStyleData(
          iconDisabledColor: Color(0xFF505255),
          iconEnabledColor: Color(0xFFA4A4A4),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 42.0,
        ),
        hint: widget.hintText?.isNotEmpty ?? false
            ? Text(
                widget.hintText!,
                style: TextStyle(
                  color: theme.hintColor,
                  fontStyle: FontStyle.italic,
                ),
                overflow: TextOverflow.ellipsis,
              )
            : null,
        isDense: true,
        isExpanded: true,
        value: widget.items?.contains(widget._controller.value) ?? false
            ? widget._controller.value
            : null,
        items: widget.isDisabled || (widget.items == null)
            ? null
            : List.generate(
                widget.items!.length,
                (index) => DropdownMenuItem<T>(
                  value: widget.items![index],
                  child: widget.itemBuilder(widget.items![index]),
                ),
                growable: false,
              ),
        onChanged: widget.isDisabled
            ? null
            : (value) {
                if (widget._controller.value != value) {
                  widget._controller.value = value;
                  widget.onSelectionChanged?.call(value);
                }
              },
      ),
    );
  }
}
