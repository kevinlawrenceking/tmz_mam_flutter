// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:tmz_damz/features/asset_import/views/asset_import_view.dart'
    as _i1;
import 'package:tmz_damz/features/asset_import/views/session_view.dart' as _i4;
import 'package:tmz_damz/features/assets/views/search_view.dart' as _i3;
import 'package:tmz_damz/features/authentication/views/login_view.dart' as _i2;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AssetImportRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AssetImportView(),
      );
    },
    AuthenticationLoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
    AssetsSearchRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetsSearchRouteArgs>(
          orElse: () => AssetsSearchRouteArgs(
                collectionID: pathParams.optString('collectionID'),
                refresh: pathParams.optBool('refresh'),
              ));
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.SearchView(
          key: args.key,
          collectionID: args.collectionID,
          refresh: args.refresh,
        ),
      );
    },
    AssetImportSessionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetImportSessionRouteArgs>(
          orElse: () => AssetImportSessionRouteArgs(
              sessionID: pathParams.getString('sessionID')));
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.SessionView(
          key: args.key,
          sessionID: args.sessionID,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AssetImportView]
class AssetImportRoute extends _i5.PageRouteInfo<void> {
  const AssetImportRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AssetImportRoute.name,
          initialChildren: children,
        );

  static const String name = 'AssetImportRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginView]
class AuthenticationLoginRoute extends _i5.PageRouteInfo<void> {
  const AuthenticationLoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AuthenticationLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationLoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SearchView]
class AssetsSearchRoute extends _i5.PageRouteInfo<AssetsSearchRouteArgs> {
  AssetsSearchRoute({
    _i6.Key? key,
    String? collectionID,
    bool? refresh,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          AssetsSearchRoute.name,
          args: AssetsSearchRouteArgs(
            key: key,
            collectionID: collectionID,
            refresh: refresh,
          ),
          rawPathParams: {
            'collectionID': collectionID,
            'refresh': refresh,
          },
          initialChildren: children,
        );

  static const String name = 'AssetsSearchRoute';

  static const _i5.PageInfo<AssetsSearchRouteArgs> page =
      _i5.PageInfo<AssetsSearchRouteArgs>(name);
}

class AssetsSearchRouteArgs {
  const AssetsSearchRouteArgs({
    this.key,
    this.collectionID,
    this.refresh,
  });

  final _i6.Key? key;

  final String? collectionID;

  final bool? refresh;

  @override
  String toString() {
    return 'AssetsSearchRouteArgs{key: $key, collectionID: $collectionID, refresh: $refresh}';
  }
}

/// generated route for
/// [_i4.SessionView]
class AssetImportSessionRoute
    extends _i5.PageRouteInfo<AssetImportSessionRouteArgs> {
  AssetImportSessionRoute({
    _i6.Key? key,
    required String sessionID,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          AssetImportSessionRoute.name,
          args: AssetImportSessionRouteArgs(
            key: key,
            sessionID: sessionID,
          ),
          rawPathParams: {'sessionID': sessionID},
          initialChildren: children,
        );

  static const String name = 'AssetImportSessionRoute';

  static const _i5.PageInfo<AssetImportSessionRouteArgs> page =
      _i5.PageInfo<AssetImportSessionRouteArgs>(name);
}

class AssetImportSessionRouteArgs {
  const AssetImportSessionRouteArgs({
    this.key,
    required this.sessionID,
  });

  final _i6.Key? key;

  final String sessionID;

  @override
  String toString() {
    return 'AssetImportSessionRouteArgs{key: $key, sessionID: $sessionID}';
  }
}
