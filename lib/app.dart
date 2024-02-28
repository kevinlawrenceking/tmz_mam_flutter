import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmz_mam_flutter/app_router.dart';
import 'package:tmz_mam_flutter/themes/app_theme.dart';
import 'package:tmz_mam_flutter/themes/theme_provider.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'TMZ Photo MAM',
            theme: AppTheme.light(context),
            darkTheme: AppTheme.dark(context),
            themeMode: ThemeMode.dark, // themeProvider.themeMode
            builder: BotToastInit(),
            routerConfig: _appRouter.config(
              navigatorObservers: () => [
                BotToastNavigatorObserver(),
              ],
            ),
          );
        },
      ),
    );
  }
}
