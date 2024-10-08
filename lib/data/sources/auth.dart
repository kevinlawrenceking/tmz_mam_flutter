import 'dart:convert';
import 'dart:io';

import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/shared/empty.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IAuthDataSource {
  Future<Either<Failure, String>> authenticate({
    required String username,
    required String password,
  });

  Future<Either<Failure, String>> getAuthToken();

  Future<Either<Failure, AccessControlPermissionMapModel>> getPermissions();

  Future<Either<Failure, Empty>> logout();

  Future<Either<Failure, String>> refreshToken();
}

class AuthDataSource implements IAuthDataSource {
  // Randomly generated keys are used here since they are
  // human-readable in web browsers storage.
  static const kAuthTokenStorageKey =
      's2FQQXcO6Y7mINRqv85DVuP0FpKXHwHTWRi0RwyT';
  static const kPermissionsStorageKey =
      'L2VJGQWVUl5lPL3qX406O7s6Z5EoSsYujbTfyz33';

  final IRestClient _client;

  // final _storage = const FlutterSecureStorage();

  AuthDataSource({
    required IRestClient client,
  }) : _client = client;

  @override
  Future<Either<Failure, String>> authenticate({
    required String username,
    required String password,
  }) =>
      ExceptionHandler<String>(() async {
        final response = await _client.post(
          endPoint: '/login',
          body: {
            'username': username,
            'password': password,
          },
        );

        if (response.statusCode != HttpStatus.ok) {
          return Left(
            HttpFailure.fromResponse(response),
          );
        }

        final data = json.decode(response.body) as Map<String, dynamic>;

        final authToken = data['token'];

        if (authToken == null) {
          return const Left(AuthFailure());
        }

        final storage = await LocalStorage.getInstance();
        await storage.setString(kAuthTokenStorageKey, authToken);

        // await _storage.write(
        //   key: kAuthTokenKey,
        //   value: authToken,
        // );

        final permissionsResult = (await _refreshPermissions(
          authToken: authToken,
        ))
            .fold(
          (failure) => failure,
          (_) => null,
        );

        if (permissionsResult != null) {
          return Left(permissionsResult);
        }

        return Right(authToken);
      })();

  @override
  Future<Either<Failure, String>> getAuthToken() async =>
      ExceptionHandler<String>(() async {
        final storage = await LocalStorage.getInstance();
        final authToken = storage.getString(kAuthTokenStorageKey);

        // final authToken = await _storage.read(
        //   key: kAuthTokenKey,
        // );

        if ((authToken == null) || JwtDecoder.isExpired(authToken)) {
          return const Left(SessionExpiredFailure());
        }

        return Right(authToken);
      })();

  @override
  Future<Either<Failure, AccessControlPermissionMapModel>>
      getPermissions() async =>
          ExceptionHandler<AccessControlPermissionMapModel>(() async {
            final storage = await LocalStorage.getInstance();
            final permissionsJson = storage.getString(kPermissionsStorageKey);

            // final permissionsJson = await _storage.read(
            //   key: kPermissionsKey,
            // );

            if (permissionsJson == null) {
              return const Left(SessionExpiredFailure());
            }

            final data = json.decode(permissionsJson);
            final model = AccessControlPermissionMapModel.fromJsonDto(data);

            return Right(model);
          })();

  @override
  Future<Either<Failure, Empty>> logout() async =>
      ExceptionHandler<Empty>(() async {
        final storage = await LocalStorage.getInstance();
        await storage.remove(kAuthTokenStorageKey);

        // await _storage.write(
        //   key: kAuthTokenKey,
        //   value: null,
        // );

        return const Right(Empty());
      })();

  @override
  Future<Either<Failure, String>> refreshToken() =>
      ExceptionHandler<String>(() async {
        final storage = await LocalStorage.getInstance();
        final authToken = storage.getString(kAuthTokenStorageKey);

        // final authToken = await _storage.read(
        //   key: kAuthTokenKey,
        // );

        if ((authToken == null) || JwtDecoder.isExpired(authToken)) {
          return const Left(SessionExpiredFailure());
        }

        final response = await _client.get(
          authToken: authToken,
          endPoint: '/token',
        );

        if (response.statusCode != HttpStatus.ok) {
          return Left(
            HttpFailure.fromResponse(response),
          );
        }

        final data = json.decode(response.body) as Map<String, dynamic>;

        final newAuthToken = data['token'];

        if (newAuthToken == null) {
          return const Left(AuthFailure());
        }

        await storage.setString(kAuthTokenStorageKey, newAuthToken);

        // await _storage.write(
        //   key: kAuthTokenKey,
        //   value: newAuthToken,
        // );

        return Right(newAuthToken);
      })();

  Future<Either<Failure, AccessControlPermissionMapModel>> _refreshPermissions({
    required String authToken,
  }) async {
    final response = await _client.get(
      authToken: authToken,
      endPoint: '/api/v1/user/permissions',
    );

    if (response.statusCode != HttpStatus.ok) {
      return Left(
        HttpFailure.fromResponse(response),
      );
    }

    final data = json.decode(response.body);
    final model = AccessControlPermissionMapModel.fromJsonDto(data);

    final storage = await LocalStorage.getInstance();
    await storage.setString(kPermissionsStorageKey, response.body);

    return Right(model);
  }
}
