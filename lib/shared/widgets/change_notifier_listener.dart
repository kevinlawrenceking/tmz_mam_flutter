import 'package:flutter/material.dart';

class ChangeNotifierListener<T extends ChangeNotifier?> extends StatefulWidget {
  final T notifier;
  final void Function() listener;
  final Widget child;

  const ChangeNotifierListener({
    super.key,
    required this.notifier,
    required this.listener,
    required this.child,
  });

  @override
  State<ChangeNotifierListener<T>> createState() =>
      _ChangeNotifierListenerState<T>();
}

class _ChangeNotifierListenerState<T extends ChangeNotifier?>
    extends State<ChangeNotifierListener<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.notifier?.removeListener(_callback);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.notifier?.addListener(_callback);
  }

  void _callback() => widget.listener();
}
