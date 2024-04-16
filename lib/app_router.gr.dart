// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/foundation.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:tmz_damz/features/asset_details/views/asset_details_view.dart'
    as _i1;
import 'package:tmz_damz/features/asset_import/views/asset_import_view.dart'
    as _i2;
import 'package:tmz_damz/features/asset_import/views/session_view.dart' as _i5;
import 'package:tmz_damz/features/assets/views/search_view.dart' as _i4;
import 'package:tmz_damz/features/authentication/views/login_view.dart' as _i3;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AssetDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetDetailsRouteArgs>(
          orElse: () =>
              AssetDetailsRouteArgs(assetID: pathParams.getString('assetID')));
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AssetDetailsView(
          key: args.key,
          assetID: args.assetID,
        ),
      );
    },
    AssetImportRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AssetImportView(),
      );
    },
    AuthenticationLoginRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginView(),
      );
    },
    AssetsSearchRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetsSearchRouteArgs>(
          orElse: () => AssetsSearchRouteArgs(
              collectionID: pathParams.optString('collectionID')));
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.SearchView(
          key: args.key,
          collectionID: args.collectionID,
        ),
      );
    },
    AssetImportSessionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetImportSessionRouteArgs>(
          orElse: () => AssetImportSessionRouteArgs(
              sessionID: pathParams.getString('sessionID')));
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SessionView(
          key: args.key,
          sessionID: args.sessionID,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AssetDetailsView]
class AssetDetailsRoute extends _i6.PageRouteInfo<AssetDetailsRouteArgs> {
  AssetDetailsRoute({
    _i7.Key? key,
    required String assetID,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          AssetDetailsRoute.name,
          args: AssetDetailsRouteArgs(
            key: key,
            assetID: assetID,
          ),
          rawPathParams: {'assetID': assetID},
          initialChildren: children,
        );

  static const String name = 'AssetDetailsRoute';

  static const _i6.PageInfo<AssetDetailsRouteArgs> page =
      _i6.PageInfo<AssetDetailsRouteArgs>(name);
}

class AssetDetailsRouteArgs {
  const AssetDetailsRouteArgs({
    this.key,
    required this.assetID,
  });

  final _i7.Key? key;

  final String assetID;

  @override
  String toString() {
    return 'AssetDetailsRouteArgs{key: $key, assetID: $assetID}';
  }
}

/// generated route for
/// [_i2.AssetImportView]
class AssetImportRoute extends _i6.PageRouteInfo<void> {
  const AssetImportRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AssetImportRoute.name,
          initialChildren: children,
        );

  static const String name = 'AssetImportRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginView]
class AuthenticationLoginRoute extends _i6.PageRouteInfo<void> {
  const AuthenticationLoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AuthenticationLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationLoginRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SearchView]
class AssetsSearchRoute extends _i6.PageRouteInfo<AssetsSearchRouteArgs> {
  AssetsSearchRoute({
    _i7.Key? key,
    String? collectionID,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          AssetsSearchRoute.name,
          args: AssetsSearchRouteArgs(
            key: key,
            collectionID: collectionID,
          ),
          rawPathParams: {'collectionID': collectionID},
          initialChildren: children,
        );

  static const String name = 'AssetsSearchRoute';

  static const _i6.PageInfo<AssetsSearchRouteArgs> page =
      _i6.PageInfo<AssetsSearchRouteArgs>(name);
}

class AssetsSearchRouteArgs {
  const AssetsSearchRouteArgs({
    this.key,
    this.collectionID,
  });

  final _i7.Key? key;

  final String? collectionID;

  @override
  String toString() {
    return 'AssetsSearchRouteArgs{key: $key, collectionID: $collectionID}';
  }
}

/// generated route for
/// [_i5.SessionView]
class AssetImportSessionRoute
    extends _i6.PageRouteInfo<AssetImportSessionRouteArgs> {
  AssetImportSessionRoute({
    _i8.Key? key,
    required String sessionID,
    List<_i6.PageRouteInfo>? children,
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

  static const _i6.PageInfo<AssetImportSessionRouteArgs> page =
      _i6.PageInfo<AssetImportSessionRouteArgs>(name);
}

class AssetImportSessionRouteArgs {
  const AssetImportSessionRouteArgs({
    this.key,
    required this.sessionID,
  });

  final _i8.Key? key;

  final String sessionID;

  @override
  String toString() {
    return 'AssetImportSessionRouteArgs{key: $key, sessionID: $sessionID}';
  }
}
