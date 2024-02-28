import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum LayoutModeEnum {
  list,
  tile,
}

class LayoutModeSelector extends StatelessWidget {
  final LayoutModeEnum initialMode;
  final void Function(LayoutModeEnum mode) onChanged;

  const LayoutModeSelector({
    super.key,
    required this.initialMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6.0),
            topLeft: Radius.circular(6.0),
          ),
          icon: MdiIcons.viewGrid,
          value: LayoutModeEnum.tile,
        ),
        _buildButton(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
          icon: MdiIcons.viewList,
          value: LayoutModeEnum.list,
        ),
      ],
    );
  }

  Widget _buildButton({
    required BorderRadiusGeometry borderRadius,
    required IconData icon,
    required LayoutModeEnum value,
  }) {
    return SizedBox(
      width: 54,
      height: 40,
      child: IconButton(
        onPressed: initialMode != value ? () => onChanged(value) : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            Color? backgroundColor;

            if (initialMode == value) {
              backgroundColor = const Color(0xFF8E0000);
            } else {
              backgroundColor = const Color(0x30FFFFFF);
            }

            return backgroundColor;
          }),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.resolveWith(
            (states) {
              return RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0x80000000),
                ),
                borderRadius: borderRadius,
              );
            },
          ),
        ),
        icon: Icon(
          icon,
          color: initialMode == value
              ? const Color(0xDEFFFFFF)
              : const Color(0xAEFFFFFF),
          size: 24,
        ),
      ),
    );
  }
}
