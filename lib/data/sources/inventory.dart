import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tmz_mam_flutter/data/models/inventory.dart';
import 'package:tmz_mam_flutter/data/models/inventory_details.dart';
import 'package:tmz_mam_flutter/data/models/inventory_sort_field_enum.dart';
import 'package:tmz_mam_flutter/data/models/sort_direction_enum.dart';
import 'package:tmz_mam_flutter/data/providers/rest_client.dart';
import 'package:tmz_mam_flutter/data/sources/auth.dart';
import 'package:tmz_mam_flutter/shared/errors/exception_handler.dart';
import 'package:tmz_mam_flutter/shared/errors/failures/failure.dart';

abstract class IInventoryDataSource {
  Future<Either<Failure, InventoryDetailsModel>> getInventoryDetails({
    required int itemID,
  });

  Future<Either<Failure, InventorySearchResults>> search({
    required int limit,
    required int offset,
    String? searchTerm,
    InventorySortFieldEnum? sortField,
    SortDirectionEnum? sortDirection,
  });
}

class InventoryDataSource implements IInventoryDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  InventoryDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, InventoryDetailsModel>> getInventoryDetails({
    required int itemID,
  }) async =>
      ExceptionHandler<InventoryDetailsModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.get(
              authToken: authToken,
              endPoint: '/api/v1/inventory/$itemID',
            );

            if (response.statusCode == 200) {
              final data = json.decode(response.body);
              final item = InventoryDetailsModel.fromJson(data);
              return Right(item);
            } else {
              return Left(
                GeneralFailure(
                  message: response.reasonPhrase,
                ),
              );
            }
          },
        );
      })();

  @override
  Future<Either<Failure, InventorySearchResults>> search({
    required int limit,
    required int offset,
    String? searchTerm,
    InventorySortFieldEnum? sortField,
    SortDirectionEnum? sortDirection,
  }) async =>
      ExceptionHandler<InventorySearchResults>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final queryParams = {
              'limit': limit.toString(),
              'offset': offset.toString(),
            };

            if (searchTerm != null && searchTerm.isNotEmpty) {
              queryParams['searchTerm'] = searchTerm;
            }

            if (sortField != null) {
              const paramKey = 'sortField';

              switch (sortField) {
                case InventorySortFieldEnum.name:
                  queryParams[paramKey] = 'name';
                  break;
                case InventorySortFieldEnum.dateCreated:
                  queryParams[paramKey] = 'dateCreated';
                  break;
                case InventorySortFieldEnum.dateUpdated:
                  queryParams[paramKey] = 'dateUpdated';
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
              endPoint: '/api/v1/inventory',
              queryParams: queryParams,
            );

            if (response.statusCode == 200) {
              final data = json.decode(response.body);
              final results = InventorySearchResults.fromJson(data);
              return Right(results);
            } else {
              return Left(
                GeneralFailure(
                  message: response.reasonPhrase,
                ),
              );
            }
          },
        );
      })();
}

class InventorySearchResults {
  final int totalRecords;
  final List<InventoryModel> items;

  InventorySearchResults({
    required this.totalRecords,
    required this.items,
  });

  factory InventorySearchResults.fromJson(
    Map<String, dynamic> json,
  ) {
    return InventorySearchResults(
      totalRecords: json['totalRecords'] as int,
      items: ((json['inventoryList'] as List?) ?? [])
          .map((item) => InventoryModel.fromJson(item))
          .toList(),
    );
  }
}
