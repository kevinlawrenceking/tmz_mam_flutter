import 'package:flutter/foundation.dart';

class RouteChangeNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
