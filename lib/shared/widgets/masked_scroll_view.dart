import 'package:flutter/material.dart';
import 'package:tmz_damz/shared/widgets/masked_container.dart';

class MaskedScrollView extends StatelessWidget {
  final ScrollController controller;
  final EdgeInsets padding;
  final bool alwaysShowScrollbar;
  final Color color;
  final Widget child;

  MaskedScrollView({
    super.key,
    ScrollController? controller,
    this.padding = const EdgeInsets.all(32),
    this.alwaysShowScrollbar = false,
    this.color = const Color(0xFF2A2D33),
    required this.child,
  }) : controller = controller ?? ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: alwaysShowScrollbar,
      child: MaskedContainer(
        color: color,
        child: SingleChildScrollView(
          controller: controller,
          clipBehavior: Clip.antiAlias,
          padding: padding,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: child,
        ),
      ),
    );
  }
}
