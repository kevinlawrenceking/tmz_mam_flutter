import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/app.dart';
import 'package:tmz_mam_flutter/utils/service_locator.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  HttpOverrides.global = CustomHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  initServiceLocator();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    const windowOptions = WindowOptions(
      center: true,
      skipTaskbar: false,
      size: Size(1200, 800),
      minimumSize: Size(1200, 800),
      title: 'TMZ Photo MAM',
    );

    await windowManager.waitUntilReadyToShow(
      windowOptions,
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  runApp(App());
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  }
}
