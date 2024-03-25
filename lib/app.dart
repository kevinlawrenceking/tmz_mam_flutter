import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:tmz_damz/app_router.dart';
import 'package:tmz_damz/shared/widgets/app_scaffold/app_scaffold.dart';
import 'package:tmz_damz/themes/app_theme.dart';
import 'package:tmz_damz/themes/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final router = GetIt.instance<AppRouter>();

            return Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppScaffold(
                    router: router,
                  ),
                  Expanded(
                    child: MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      title: 'TMZ DAMZ',
                      theme: AppTheme.light(context),
                      darkTheme: AppTheme.dark(context),
                      themeMode: ThemeMode.dark, // themeProvider.themeMode
                      builder: (context, child) {
                        return BotToastInit()(
                          context,
                          Material(
                            child: child,
                          ),
                        );
                      },
                      routerConfig: router.config(
                        navigatorObservers: () => [
                          BotToastNavigatorObserver(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
