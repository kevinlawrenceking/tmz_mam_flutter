import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/data/sources/asset_import_session.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/features/asset_import/service_locator.dart'
    as asset_import;
import 'package:tmz_damz/features/assets/service_locator.dart' as assets;
import 'package:tmz_damz/features/authentication/service_locator.dart'
    as authentication;
import 'package:tmz_damz/utils/config.dart';

void initServiceLocator() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<Config>(
    () {
      // TODO: get this from ENV variable...
      const apiBaseAddress = 'http://localhost:3000';

      return Config(
        apiBaseAddress: apiBaseAddress,
        apiBaseUrl: '$apiBaseAddress/api/v1',
      );
    },
  );

  _initRestClient();
  _initDataSources();

  asset_import.ServiceLocator.init();
  assets.ServiceLocator.init();
  authentication.ServiceLocator.init();
}

void _initDataSources() {
  final sl = GetIt.instance;

  sl.registerSingleton<IAuthDataSource>(
    AuthDataSource(
      client: sl(),
    ),
  );

  sl.registerSingleton<IAssetDataSource>(
    AssetDataSource(
      auth: sl(),
      client: sl(),
    ),
  );

  sl.registerSingleton<IAssetImportSessionDataSource>(
    AssetImportSessionDataSource(
      auth: sl(),
      client: sl(),
    ),
  );
}

void _initRestClient() {
  final sl = GetIt.instance;

  sl.registerSingleton<IRestClient>(
    RestClient(
      baseUrl: sl<Config>().apiBaseAddress,
    ),
  );
}
