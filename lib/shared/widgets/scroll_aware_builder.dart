import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: avoid_positional_boolean_parameters
typedef VisibilityChanged = void Function(bool visible);

class ScrollAwareBuilder extends StatefulWidget {
  final ScrollController controller;
  final WidgetBuilder builder;

  const ScrollAwareBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  State<ScrollAwareBuilder> createState() => _ScrollAwareBuilderState();
}

class _ScrollAwareBuilderState extends State<ScrollAwareBuilder> {
  bool _build = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      if (!_build && _shouldBuild()) {
        setState(() => _build = true);
      }
    });

    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);

    super.dispose();
  }

  void _onScroll() {
    if (!mounted) {
      return;
    }

    if (!_build && _shouldBuild()) {
      setState(() => _build = true);
    }
  }

  bool _shouldBuild() {
    final renderObject = context.findRenderObject();
    if (renderObject == null) {
      return false;
    }

    final viewport = RenderAbstractViewport.of(renderObject);
    final objectOffset = viewport.getOffsetToReveal(renderObject, 0.0).offset;

    final scrollWindow = Rect.fromLTWH(
      viewport.paintBounds.left,
      viewport.paintBounds.top + widget.controller.offset,
      viewport.paintBounds.width,
      viewport.paintBounds.height,
    );

    return !_build && (objectOffset < scrollWindow.bottom);
  }

  @override
  Widget build(BuildContext context) {
    if (!_build && _shouldBuild()) {
      _build = true;
    }

    return _build ? widget.builder(context) : const SizedBox();
  }
}
