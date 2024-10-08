import 'package:get_it/get_it.dart';
import 'package:tmz_damz/features/asset_import/bloc/file_bloc.dart';
import 'package:tmz_damz/features/asset_import/bloc/session_bloc.dart';

class ServiceLocator {
  static bool _initialized = false;

  static void init() {
    if (_initialized) {
      throw Exception('Service locator already initialized!');
    }

    final sl = GetIt.instance;

    sl.registerFactory(
      () => FileBloc(
        assetImportSessionDataSource: sl(),
      ),
    );

    sl.registerFactory(
      () => SessionBloc(
        assetImportSessionDataSource: sl(),
      ),
    );

    _initialized = true;
  }
}
