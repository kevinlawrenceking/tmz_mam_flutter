import 'dart:async';

class DebounceTimer {
  final Duration _delay;
  Timer? _timer;

  DebounceTimer({
    Duration delay = const Duration(milliseconds: 300),
  }) : _delay = delay;

  void wrap(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(_delay, callback);
  }
}
