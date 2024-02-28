import 'package:get_it/get_it.dart';
import 'package:tmz_mam_flutter/data/providers/rest_client.dart';
import 'package:tmz_mam_flutter/data/sources/auth.dart';
import 'package:tmz_mam_flutter/data/sources/inventory.dart';
import 'package:tmz_mam_flutter/features/assets/service_locator.dart' as assets;
import 'package:tmz_mam_flutter/features/authentication/service_locator.dart'
    as auth;

void initServiceLocator() {
  _initRestClient();
  _initDataSources();

  assets.ServiceLocator.init();
  auth.ServiceLocator.init();
}

void _initDataSources() {
  final sl = GetIt.instance;

  sl.registerSingleton<IAuthDataSource>(
    AuthDataSource(
      client: sl(),
    ),
  );

  sl.registerSingleton<IInventoryDataSource>(
    InventoryDataSource(
      auth: sl(),
      client: sl(),
    ),
  );
}

void _initRestClient() {
  final sl = GetIt.instance;

  sl.registerSingleton<IRestClient>(
    RestClient(
      // TODO: get this from ENV variable...
      baseUrl: 'http://localhost:3000',
    ),
  );
}
