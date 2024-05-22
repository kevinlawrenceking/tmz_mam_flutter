import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/shared/widgets/content_menus/selectable_region_context_menu_builder.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class CopyText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const CopyText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  State<CopyText> createState() => _CopyTextState();
}

class _CopyTextState extends State<CopyText> {
  late FocusNode _focusNode;

  bool _copyButtonHover = false;
  String? _selectedText;

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusChanged);

    _focusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    FocusManager.instance.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCopyButton(),
        const SizedBox(width: 2.0),
        Flexible(
          child: Focus(
            focusNode: _focusNode,
            child: SelectionArea(
              contextMenuBuilder: (context, selectableRegionState) =>
                  kSelectableRegionContextMenuBuilder(
                context,
                selectableRegionState,
                () async {
                  if (_selectedText == null) {
                    return;
                  }

                  await _onCopyText(_selectedText!);
                },
              ),
              onSelectionChanged: (value) {
                setState(() {
                  _selectedText = value?.plainText;
                });
              },
              child: Text(
                widget.text,
                style: widget.style,
                maxLines: widget.maxLines,
                overflow: widget.overflow,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCopyButton() {
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (event) {
            setState(() => _copyButtonHover = true);
          },
          onExit: (event) {
            setState(() => _copyButtonHover = false);
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () async {
              await _onCopyText(widget.text);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _copyButtonHover ? 1 : 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    MdiIcons.contentCopy,
                    color: Theme.of(context).textTheme.labelMedium?.color,
                    size: 14.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onCopyText(String text) async {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );

    Toast.showNotification(
      showDuration: const Duration(seconds: 3),
      type: ToastTypeEnum.success,
      message: 'Value copied to clipboard!',
    );
  }
}
