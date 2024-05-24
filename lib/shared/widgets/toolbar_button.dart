import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  final WidgetStateProperty<Color?>? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String? tooltip;
  final VoidCallback? onPressed;

  const ToolbarButton({
    super.key,
    this.backgroundColor,
    this.borderRadius,
    required this.icon,
    this.iconColor = const Color(0xAEFFFFFF),
    this.iconSize = 24.0,
    this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: backgroundColor ??
            WidgetStateProperty.all(
              const Color(0x30FFFFFF),
            ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.resolveWith(
          (states) {
            return RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0x80000000),
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(6.0),
            );
          },
        ),
      ),
      tooltip: tooltip,
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
