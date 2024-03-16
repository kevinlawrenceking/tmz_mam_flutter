// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:tmz_damz/features/asset_import/views/import_view.dart' as _i1;
import 'package:tmz_damz/features/assets/views/search_view.dart' as _i3;
import 'package:tmz_damz/features/authentication/views/login_view.dart' as _i2;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AssetImportRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetImportRouteArgs>(
          orElse: () => AssetImportRouteArgs(
              sessionID: pathParams.optString('sessionID')));
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ImportView(
          key: args.key,
          sessionID: args.sessionID,
        ),
      );
    },
    AuthenticationLoginRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
    AssetsSearchRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SearchView(),
      );
    },
  };
}

/// generated route for
/// [_i1.ImportView]
class AssetImportRoute extends _i4.PageRouteInfo<AssetImportRouteArgs> {
  AssetImportRoute({
    _i5.Key? key,
    String? sessionID,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          AssetImportRoute.name,
          args: AssetImportRouteArgs(
            key: key,
            sessionID: sessionID,
          ),
          rawPathParams: {'sessionID': sessionID},
          initialChildren: children,
        );

  static const String name = 'AssetImportRoute';

  static const _i4.PageInfo<AssetImportRouteArgs> page =
      _i4.PageInfo<AssetImportRouteArgs>(name);
}

class AssetImportRouteArgs {
  const AssetImportRouteArgs({
    this.key,
    this.sessionID,
  });

  final _i5.Key? key;

  final String? sessionID;

  @override
  String toString() {
    return 'AssetImportRouteArgs{key: $key, sessionID: $sessionID}';
  }
}

/// generated route for
/// [_i2.LoginView]
class AuthenticationLoginRoute extends _i4.PageRouteInfo<void> {
  const AuthenticationLoginRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AuthenticationLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationLoginRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SearchView]
class AssetsSearchRoute extends _i4.PageRouteInfo<void> {
  const AssetsSearchRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AssetsSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'AssetsSearchRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
