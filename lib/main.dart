import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmz_damz/app.dart';
import 'package:tmz_damz/utils/service_locator.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  HttpOverrides.global = CustomHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  const env = String.fromEnvironment('ENV');
  if (env.isEmpty) {
    return;
  }

  try {
    await dotenv.load(
      fileName: '.env.$env',
    );
    // ignore: avoid_catching_errors
  } on Error {
    return;
  }

  initServiceLocator();

  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      center: true,
      skipTaskbar: false,
      size: Size(1200, 800),
      minimumSize: Size(1200, 800),
      title: 'TMZ DAMZ',
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
