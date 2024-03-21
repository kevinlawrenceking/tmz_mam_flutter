import 'dart:convert';
import 'dart:io';

import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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

  Future<Either<Failure, Empty>> logout();

  Future<Either<Failure, String>> refreshToken();
}

class AuthDataSource implements IAuthDataSource {
  static const kAuthTokenKey = 'jwt_token';

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
          body: json.encode({
            'username': username,
            'password': password,
          }),
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
        await storage.setString(kAuthTokenKey, authToken);

        // await _storage.write(
        //   key: kAuthTokenKey,
        //   value: authToken,
        // );

        return Right(authToken);
      })();

  @override
  Future<Either<Failure, String>> getAuthToken() async =>
      ExceptionHandler<String>(() async {
        final storage = await LocalStorage.getInstance();
        final authToken = storage.getString(kAuthTokenKey);

        // final authToken = await _storage.read(
        //   key: kAuthTokenKey,
        // );

        if ((authToken == null) || JwtDecoder.isExpired(authToken)) {
          return const Left(SessionExpiredFailure());
        }

        return Right(authToken);
      })();

  @override
  Future<Either<Failure, Empty>> logout() async =>
      ExceptionHandler<Empty>(() async {
        final storage = await LocalStorage.getInstance();
        await storage.remove(kAuthTokenKey);

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
        final authToken = storage.getString(kAuthTokenKey);

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

        await storage.setString(kAuthTokenKey, authToken);

        // await _storage.write(
        //   key: kAuthTokenKey,
        //   value: newAuthToken,
        // );

        return Right(newAuthToken);
      })();
}
