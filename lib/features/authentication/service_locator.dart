import 'package:get_it/get_it.dart';
import 'package:tmz_damz/features/authentication/bloc/bloc.dart';

class ServiceLocator {
  static bool _initialized = false;

  static void init() {
    if (_initialized) {
      throw Exception('Service locator already initialized!');
    }

    final sl = GetIt.instance;

    sl.registerFactory(
      () => AuthenticationBloc(
        authSessionManager: sl(),
      ),
    );

    _initialized = true;
  }
}
