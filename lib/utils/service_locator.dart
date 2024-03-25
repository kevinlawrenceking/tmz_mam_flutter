import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/app_router.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/asset.dart';
import 'package:tmz_damz/data/sources/asset_import_session.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/data/sources/collection.dart';
import 'package:tmz_damz/data/sources/user_collection.dart';
import 'package:tmz_damz/features/asset_details/service_locator.dart'
    as asset_details;
import 'package:tmz_damz/features/asset_import/service_locator.dart'
    as asset_import;
import 'package:tmz_damz/features/assets/service_locator.dart' as assets;
import 'package:tmz_damz/features/authentication/service_locator.dart'
    as authentication;
import 'package:tmz_damz/features/user_collections/service_locator.dart'
    as user_collections;
import 'package:tmz_damz/utils/config.dart';

void initServiceLocator() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<Config>(
    () {
      final serverHost = dotenv.env['SERVER_HOST'] ?? 'localhost';
      final serverPort = dotenv.env['SERVER_PORT'] ?? '3000';
      final serverSecure =
          dotenv.env['SERVER_SECURE']?.toLowerCase() ?? 'false';

      final apiBaseAddress =
          'http${serverSecure == 'true' ? 's' : ''}://$serverHost:$serverPort';

      return Config(
        apiBaseAddress: apiBaseAddress,
        apiBaseUrl: '$apiBaseAddress/api/v1',
      );
    },
  );

  _initRestClient();
  _initDataSources();

  asset_details.ServiceLocator.init();
  asset_import.ServiceLocator.init();
  assets.ServiceLocator.init();
  user_collections.ServiceLocator.init();
  authentication.ServiceLocator.init();

  sl.registerSingleton(AppRouter());
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

  sl.registerSingleton<ICollectionDataSource>(
    CollectionDataSource(
      auth: sl(),
      client: sl(),
    ),
  );

  sl.registerSingleton<IUserCollectionDataSource>(
    UserCollectionDataSource(
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
