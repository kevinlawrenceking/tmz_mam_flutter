import 'dart:convert';
import 'dart:io';

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
}

class AuthDataSource implements IAuthDataSource {
  static const kAuthTokenKey = 'jwt_token';

  final IRestClient _client;

  final _storage = const FlutterSecureStorage();

  AuthDataSource({
    required IRestClient client,
  }) : _client = client;

  @override
  Future<Either<Failure, String>> authenticate({
    required String username,
    required String password,
  }) =>
      ExceptionHandler<String>(() async {
        final body = json.encode({
          'username': username,
          'password': password,
        });

        final response = await _client.post(
          endPoint: '/login',
          body: body,
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

        await _storage.write(
          key: kAuthTokenKey,
          value: authToken,
        );

        return Right(authToken);
      })();

  @override
  Future<Either<Failure, String>> getAuthToken() async =>
      ExceptionHandler<String>(() async {
        final authToken = await _storage.read(
          key: kAuthTokenKey,
        );

        if ((authToken == null) || JwtDecoder.isExpired(authToken)) {
          return const Left(SessionExpiredFailure());
        }

        return Right(authToken);
      })();

  @override
  Future<Either<Failure, Empty>> logout() async =>
      ExceptionHandler<Empty>(() async {
        await _storage.write(
          key: kAuthTokenKey,
          value: null,
        );

        return const Right(Empty());
      })();
}
