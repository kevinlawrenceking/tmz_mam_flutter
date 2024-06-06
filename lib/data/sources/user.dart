import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/user.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IUserDataSource {
  Future<Either<Failure, UserSearchResults>> getUserList({
    required String? searchTerm,
    required int offset,
    required int limit,
  });
}

class UserDataSource implements IUserDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  UserDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, UserSearchResults>> getUserList({
    required String? searchTerm,
    required int offset,
    required int limit,
  }) async =>
      ExceptionHandler<UserSearchResults>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final queryParams = {
              'offset': offset.toString(),
              'limit': limit.toString(),
            };

            if (searchTerm != null && searchTerm.isNotEmpty) {
              queryParams['searchTerm'] = searchTerm;
            }

            final response = await _client.get(
              authToken: authToken,
              endPoint: '/api/v1/user',
              queryParams: queryParams,
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final results = UserSearchResults.fromJsonDto(data);

            return Right(results);
          },
        );
      })();
}

class UserSearchResults {
  final int totalRecords;
  final List<UserMetaModel> users;

  UserSearchResults({
    required this.totalRecords,
    required this.users,
  });

  factory UserSearchResults.fromJsonDto(
    Map<String, dynamic> dto,
  ) {
    return UserSearchResults(
      totalRecords: dto['total_records'] as int,
      users: (dto['users'] as List?)
              ?.map(
                (_) => UserMetaModel.fromJsonDto(
                  _,
                ),
              )
              .toList() ??
          [],
    );
  }
}
