import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tmz_mam_flutter/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
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
          path: '/assets/search',
          page: AssetsSearchRoute.page,
          durationInMilliseconds: 150,
          reverseDurationInMilliseconds: 150,
          transitionsBuilder: _customTransition,
        ),
      ];

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
