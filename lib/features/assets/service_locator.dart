import 'package:get_it/get_it.dart';
import 'package:tmz_damz/features/assets/bloc/assets_bloc.dart';
import 'package:tmz_damz/features/assets/bloc/collection_bloc.dart';

class ServiceLocator {
  static bool _initialized = false;

  static void init() {
    if (_initialized) {
      throw Exception('Service locator already initialized!');
    }

    final sl = GetIt.instance;

    sl.registerFactory(
      () => AssetsBloc(
        assetDataSource: sl(),
        collectionDataSource: sl(),
      ),
    );

    sl.registerFactory(
      () => CollectionBloc(
        collectionDataSource: sl(),
      ),
    );

    _initialized = true;
  }
}
