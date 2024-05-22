import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/models/collection_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/empty.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class ICollectionDataSource {
  Future<Either<Failure, Empty>> addAssetToCollection({
    required String collectionID,
    required String assetID,
  });

  Future<Either<Failure, CollectionModel>> createCollection({
    required bool isPrivate,
    required bool autoClear,
    required String name,
    required String description,
  });

  Future<Either<Failure, Empty>> deleteCollection({
    required String collectionID,
  });

  Future<Either<Failure, CollectionModel>> getCollection({
    required String collectionID,
  });

  Future<Either<Failure, CollectionSearchResults>> getCollectionList({
    required int offset,
    required int limit,
    String? searchTerm,
    CollectionSortFieldEnum? sortField,
    SortDirectionEnum? sortDirection,
  });

  Future<Either<Failure, Empty>> moveAssetToCollection({
    required String sourceCollectionID,
    required String targetCollectionID,
    required String assetID,
  });

  Future<Either<Failure, Empty>> removeAssetFromCollection({
    required String collectionID,
    required String assetID,
  });

  Future<Either<Failure, Empty>> setCollectionOwner({
    required String collectionID,
    required String ownerID,
  });

  Future<Either<Failure, Empty>> setCollectionPosterAsset({
    required String collectionID,
    required String assetID,
  });

  Future<Either<Failure, CollectionModel>> updateCollection({
    required String collectionID,
    required bool isPrivate,
    required bool autoClear,
    required String name,
    required String description,
  });
}

class CollectionDataSource implements ICollectionDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  CollectionDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, Empty>> addAssetToCollection({
    required String collectionID,
    required String assetID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/collection/$collectionID/asset',
              body: {
                'asset_id': assetID,
              },
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
  Future<Either<Failure, CollectionModel>> createCollection({
    required bool isPrivate,
    required bool autoClear,
    required String name,
    required String description,
  }) async =>
      ExceptionHandler<CollectionModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/collection/',
              body: {
                'private': isPrivate,
                'auto_clear': autoClear,
                'name': name,
                'description': description,
              },
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final model = CollectionModel.fromJsonDto(data);

            return Right(model);
          },
        );
      })();

  @override
  Future<Either<Failure, Empty>> deleteCollection({
    required String collectionID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.delete(
              authToken: authToken,
              endPoint: '/api/v1/collection/$collectionID',
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
  Future<Either<Failure, CollectionModel>> getCollection({
    required String collectionID,
  }) async =>
      ExceptionHandler<CollectionModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.get(
              authToken: authToken,
              endPoint: '/api/v1/collection/$collectionID',
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final model = CollectionModel.fromJsonDto(data);

            return Right(model);
          },
        );
      })();

  @override
  Future<Either<Failure, CollectionSearchResults>> getCollectionList({
    required int offset,
    required int limit,
    String? searchTerm,
    CollectionSortFieldEnum? sortField,
    SortDirectionEnum? sortDirection,
  }) async =>
      ExceptionHandler<CollectionSearchResults>(() async {
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

            if (sortField != null) {
              const paramKey = 'sortField';

              switch (sortField) {
                case CollectionSortFieldEnum.name:
                  queryParams[paramKey] = 'name';
                  break;
                case CollectionSortFieldEnum.createdAt:
                  queryParams[paramKey] = 'created_at';
                  break;
                case CollectionSortFieldEnum.updatedAt:
                  queryParams[paramKey] = 'updated_at';
                  break;
                case CollectionSortFieldEnum.autoClear:
                  queryParams[paramKey] = 'auto_clear';
                  break;
                case CollectionSortFieldEnum.favorited:
                  queryParams[paramKey] = 'favorited';
                  break;
              }
            }

            if (sortDirection != null) {
              const paramKey = 'sortDirection';

              switch (sortDirection) {
                case SortDirectionEnum.ascending:
                  queryParams[paramKey] = 'asc';
                  break;
                case SortDirectionEnum.descending:
                  queryParams[paramKey] = 'desc';
                  break;
              }
            }

            final response = await _client.get(
              authToken: authToken,
              endPoint: '/api/v1/collection',
              queryParams: queryParams,
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final results = CollectionSearchResults.fromJsonDto(data);

            return Right(results);
          },
        );
      })();

  @override
  Future<Either<Failure, Empty>> moveAssetToCollection({
    required String sourceCollectionID,
    required String targetCollectionID,
    required String assetID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final addResponse = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/collection/$targetCollectionID/asset',
              body: {
                'asset_id': assetID,
              },
            );

            if (addResponse.statusCode != HttpStatus.noContent) {
              return Left(
                HttpFailure.fromResponse(addResponse),
              );
            }

            final removeResponse = await _client.delete(
              authToken: authToken,
              endPoint: '/api/v1/collection/$sourceCollectionID/asset/$assetID',
            );

            if (removeResponse.statusCode != HttpStatus.noContent) {
              return Left(
                HttpFailure.fromResponse(removeResponse),
              );
            }

            return const Right(Empty());
          },
        );
      })();

  @override
  Future<Either<Failure, Empty>> removeAssetFromCollection({
    required String collectionID,
    required String assetID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.delete(
              authToken: authToken,
              endPoint: '/api/v1/collection/$collectionID/asset/$assetID',
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
  Future<Either<Failure, Empty>> setCollectionOwner({
    required String collectionID,
    required String ownerID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/collection/$collectionID/setOwner',
              body: {
                'owner_id': ownerID,
              },
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
  Future<Either<Failure, Empty>> setCollectionPosterAsset({
    required String collectionID,
    required String assetID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/collection/$collectionID/setPosterAsset',
              body: {
                'asset_id': assetID,
              },
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
  Future<Either<Failure, CollectionModel>> updateCollection({
    required String collectionID,
    required bool isPrivate,
    required bool autoClear,
    required String name,
    required String description,
  }) async =>
      ExceptionHandler<CollectionModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/collection/$collectionID',
              body: {
                'private': isPrivate,
                'auto_clear': autoClear,
                'name': name,
                'description': description,
              },
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final model = CollectionModel.fromJsonDto(data);

            return Right(model);
          },
        );
      })();
}

class CollectionSearchResults {
  final int totalRecords;
  final List<CollectionModel> collections;

  CollectionSearchResults({
    required this.totalRecords,
    required this.collections,
  });

  factory CollectionSearchResults.fromJsonDto(
    Map<String, dynamic> dto,
  ) {
    return CollectionSearchResults(
      totalRecords: dto['total_records'] as int,
      collections: (dto['collections'] as List?)
              ?.map(
                (_) => CollectionModel.fromJsonDto(
                  _,
                ),
              )
              .toList() ??
          [],
    );
  }
}
