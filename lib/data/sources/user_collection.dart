import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/empty.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IUserCollectionDataSource {
  Future<Either<Failure, Empty>> addCollection({
    required String collectionID,
  });

  Future<Either<Failure, List<CollectionModel>>> getCollectionList();

  Future<Either<Failure, Empty>> removeCollection({
    required String collectionID,
  });
}

class UserCollectionDataSource implements IUserCollectionDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  UserCollectionDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, Empty>> addCollection({
    required String collectionID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/user/collection/$collectionID',
            );

            if (response.statusCode != HttpStatus.noContent) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            return const Right(Empty());
          },
        );
      })();

  @override
  Future<Either<Failure, List<CollectionModel>>> getCollectionList() async =>
      ExceptionHandler<List<CollectionModel>>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.get(
              authToken: authToken,
              endPoint: '/api/v1/user/collection',
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final collections = (data as List?)
                    ?.map(
                      (_) => CollectionModel.fromJsonDto(
                        _,
                      ),
                    )
                    .toList() ??
                [];

            return Right(collections);
          },
        );
      })();

  @override
  Future<Either<Failure, Empty>> removeCollection({
    required String collectionID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.delete(
              authToken: authToken,
              endPoint: '/api/v1/user/collection/$collectionID',
            );

            if (response.statusCode != HttpStatus.noContent) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            return const Right(Empty());
          },
        );
      })();
}
