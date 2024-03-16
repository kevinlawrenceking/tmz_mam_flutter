import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/data/sources/auth.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        RedirectRoute(
          path: '/',
          redirectTo: '/assets/search',
        ),
        CustomRoute(
          path: '/login',
          page: AuthenticationLoginRoute.page,
          durationInMilliseconds: 150,
          initial: true,
          keepHistory: false,
          reverseDurationInMilliseconds: 150,
          transitionsBuilder: _customTransition,
        ),
        CustomRoute(
          path: '/assets/import/:sessionID',
          page: AssetImportRoute.page,
          durationInMilliseconds: 150,
          reverseDurationInMilliseconds: 150,
          transitionsBuilder: _customTransition,
        ),
        CustomRoute(
          path: '/assets/search',
          page: AssetsSearchRoute.page,
          durationInMilliseconds: 150,
          reverseDurationInMilliseconds: 150,
          transitionsBuilder: _customTransition,
        ),
      ];

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (resolver.route.name == AuthenticationLoginRoute.name) {
      resolver.next();
      return;
    }

    final authDataSource = GetIt.instance<IAuthDataSource>();
    final result = await authDataSource.getAuthToken();

    result.fold(
      (failure) => resolver.redirect(const AuthenticationLoginRoute()),
      (_) => resolver.next(),
    );
  }

  static Widget _customTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
