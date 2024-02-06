import 'package:flutter/material.dart';

/// A widget that wraps another widget to keep it alive in a [TabBarView] or
/// within a [PageView].
///
/// This wrapper uses [AutomaticKeepAliveClientMixin] to request that the
/// wrapped widget be kept alive, meaning it will not be disposed when it is
/// scrolled out of view in a lazy-loaded list or paged view.
///
/// Usage example:
/// ```dart
/// TabBarView(
///   children: [
///     KeepAliveWidgetWrapper(
///       builder: (BuildContext context) => MyCustomWidget(),
///     ),
///     // Other tab views...
///   ],
/// )
/// ```
///
/// The `builder` function is used to build the child widget that needs to be
/// kept alive.

class KeepAliveWidgetWrapper extends StatefulWidget {
  const KeepAliveWidgetWrapper({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  State<KeepAliveWidgetWrapper> createState() => _KeepAliveWidgetWrapperState();
}

class _KeepAliveWidgetWrapperState extends State<KeepAliveWidgetWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.builder(context);
  }
}
