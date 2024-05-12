import 'package:flutter/material.dart';

class MaskedContainer extends ShaderMask {
  final Color color;

  MaskedContainer({
    super.key,
    this.color = const Color(0xFF2A2D33),
    required Widget super.child,
  }) : super(
          blendMode: BlendMode.dstOut,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.0,
                10.0 / bounds.height,
                1.0 - (10.0 / bounds.height),
                1.0,
              ],
              colors: [
                color,
                Colors.transparent,
                Colors.transparent,
                color,
              ],
            ).createShader(bounds);
          },
        );
}
