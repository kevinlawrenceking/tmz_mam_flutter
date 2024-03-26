import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IAssetDataSource {
  Future<Either<Failure, AssetDetailsModel>> getAssetDetails({
    required String assetID,
  });

  Future<Either<Failure, AssetSearchResults>> getAssetList({
    required int offset,
    required int limit,
    String? collectionID,
    String? searchTerm,
    AssetSortFieldEnum? sortField,
    SortDirectionEnum? sortDirection,
  });
}

class AssetDataSource implements IAssetDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  AssetDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, AssetDetailsModel>> getAssetDetails({
    required String assetID,
  }) async =>
      ExceptionHandler<AssetDetailsModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.get(
              authToken: authToken,
              endPoint: '/api/v1/asset/$assetID/details',
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final model = AssetDetailsModel.fromJsonDto(data);

            return Right(model);
          },
        );
      })();

  @override
  Future<Either<Failure, AssetSearchResults>> getAssetList({
    required int offset,
    required int limit,
    String? collectionID,
    String? searchTerm,
    AssetSortFieldEnum? sortField,
    SortDirectionEnum? sortDirection,
  }) async =>
      ExceptionHandler<AssetSearchResults>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final queryParams = {
              'offset': offset.toString(),
              'limit': limit.toString(),
            };

            if ((collectionID != null) && collectionID.isNotEmpty) {
              queryParams['collectionID'] = collectionID;
            }

            if ((searchTerm != null) && searchTerm.isNotEmpty) {
              queryParams['searchTerm'] = searchTerm;
            }

            if (sortField != null) {
              const paramKey = 'sortField';

              switch (sortField) {
                case AssetSortFieldEnum.headline:
                  queryParams[paramKey] = 'headline';
                  break;
                case AssetSortFieldEnum.createdAt:
                  queryParams[paramKey] = 'created_at';
                  break;
                case AssetSortFieldEnum.updatedAt:
                  queryParams[paramKey] = 'updated_at';
                  break;
                case AssetSortFieldEnum.agency:
                  queryParams[paramKey] = 'agency';
                  break;
                case AssetSortFieldEnum.celebrityAssociated:
                  queryParams[paramKey] = 'celebrity_associated';
                  break;
                case AssetSortFieldEnum.celebrityInPhoto:
                  queryParams[paramKey] = 'celebrity_in_photo';
                  break;
                case AssetSortFieldEnum.credit:
                  queryParams[paramKey] = 'credit';
                  break;
                case AssetSortFieldEnum.creditLocation:
                  queryParams[paramKey] = 'credit_location';
                  break;
                case AssetSortFieldEnum.keywords:
                  queryParams[paramKey] = 'keywords';
                  break;
                case AssetSortFieldEnum.originalFileName:
                  queryParams[paramKey] = 'original_file_name';
                  break;
                case AssetSortFieldEnum.rights:
                  queryParams[paramKey] = 'rights';
                  break;
                case AssetSortFieldEnum.rightsDetails:
                  queryParams[paramKey] = 'rights_details';
                  break;
                case AssetSortFieldEnum.shotDescription:
                  queryParams[paramKey] = 'shot_description';
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
              endPoint: '/api/v1/asset',
              queryParams: queryParams,
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final results = AssetSearchResults.fromJsonDto(data);

            return Right(results);
          },
        );
      })();
}

class AssetSearchResults {
  final int totalRecords;
  final List<AssetDetailsModel> assets;

  AssetSearchResults({
    required this.totalRecords,
    required this.assets,
  });

  factory AssetSearchResults.fromJsonDto(
    Map<String, dynamic> dto,
  ) {
    return AssetSearchResults(
      totalRecords: dto['total_records'] as int,
      assets: (dto['assets'] as List?)
              ?.map(
                (_) => AssetDetailsModel.fromJsonDto(
                  _,
                ),
              )
              .toList() ??
          [],
    );
  }
}
