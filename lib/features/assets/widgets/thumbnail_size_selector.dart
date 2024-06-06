import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/shared/widgets/toolbar_button.dart';

enum ThumbnailSizeEnum {
  small,
  medium,
  large,
}

class ThumbnailSizeSelector extends StatelessWidget {
  final ThumbnailSizeEnum initialSize;
  final void Function(ThumbnailSizeEnum size) onChanged;

  const ThumbnailSizeSelector({
    super.key,
    required this.initialSize,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6.0),
            topLeft: Radius.circular(6.0),
          ),
          iconSize: 18.0,
          value: ThumbnailSizeEnum.small,
        ),
        _buildButton(
          borderRadius: BorderRadius.zero,
          iconSize: 24.0,
          value: ThumbnailSizeEnum.medium,
        ),
        _buildButton(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
          iconSize: 30.0,
          value: ThumbnailSizeEnum.large,
        ),
      ],
    );
  }

  Widget _buildButton({
    required BorderRadiusGeometry borderRadius,
    required double iconSize,
    required ThumbnailSizeEnum value,
  }) {
    BorderRadiusGeometry borderRadius;

    switch (value) {
      case ThumbnailSizeEnum.small:
        borderRadius = const BorderRadius.only(
          bottomLeft: Radius.circular(6.0),
          topLeft: Radius.circular(6.0),
        );
        break;
      case ThumbnailSizeEnum.large:
        borderRadius = const BorderRadius.only(
          bottomRight: Radius.circular(6.0),
          topRight: Radius.circular(6.0),
        );
        break;
      default:
        borderRadius = BorderRadius.zero;
        break;
    }

    return SizedBox(
      width: 54,
      height: 42,
      child: ToolbarButton(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          Color? backgroundColor;

          if (initialSize == value) {
            backgroundColor = const Color(0xFF8E0000);
          } else {
            backgroundColor = const Color(0x30FFFFFF);
          }

          return backgroundColor;
        }),
        borderRadius: borderRadius,
        icon: MdiIcons.imageOutline,
        iconColor: (initialSize == value)
            ? const Color(0xDEFFFFFF)
            : const Color(0xAEFFFFFF),
        iconSize: iconSize,
        tooltip: {
          ThumbnailSizeEnum.small: 'Small',
          ThumbnailSizeEnum.medium: 'Medium',
          ThumbnailSizeEnum.large: 'Large',
        }[value],
        onPressed: (initialSize != value) ? () => onChanged(value) : null,
      ),
    );
  }
}
