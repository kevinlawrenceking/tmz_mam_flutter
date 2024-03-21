import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class CopyText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final bool canCopy;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const CopyText(
    this.text, {
    super.key,
    this.style,
    this.canCopy = false,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  @override
  State<CopyText> createState() => _CopyTextState();
}

class _CopyTextState extends State<CopyText> {
  bool _copyButtonHover = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: widget.canCopy
              ? const EdgeInsets.only(left: 18.0)
              : EdgeInsets.zero,
          child: Text(
            widget.text,
            style: widget.style,
            maxLines: widget.maxLines,
            overflow: widget.overflow,
            softWrap: widget.softWrap,
          ),
        ),
        if (widget.canCopy) _buildCopyButton(),
      ],
    );
  }

  Widget _buildCopyButton() {
    return Positioned.fill(
      child: StatefulBuilder(
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
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text: widget.text,
                  ),
                );

                // Toast.showNotification(
                //   type: ToastTypeEnum.success,
                //   message: 'Value copied to clipboard!',
                // );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _copyButtonHover ? 1 : 0.2,
                  child: Icon(
                    MdiIcons.contentCopy,
                    color: Theme.of(context).textTheme.labelMedium?.color,
                    size: 12.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
