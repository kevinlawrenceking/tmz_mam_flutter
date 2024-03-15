// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:tmz_damz/features/assets/views/search_view.dart' as _i2;
import 'package:tmz_damz/features/authentication/views/login_view.dart' as _i1;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    AuthenticationLoginRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginView(),
      );
    },
    AssetsSearchRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.SearchView(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginView]
class AuthenticationLoginRoute extends _i3.PageRouteInfo<void> {
  const AuthenticationLoginRoute({List<_i3.PageRouteInfo>? children})
      : super(
          AuthenticationLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationLoginRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SearchView]
class AssetsSearchRoute extends _i3.PageRouteInfo<void> {
  const AssetsSearchRoute({List<_i3.PageRouteInfo>? children})
      : super(
          AssetsSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'AssetsSearchRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
