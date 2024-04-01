import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/picklist_keyword.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IPicklistKeywordDataSource {
  Future<Either<Failure, PicklistKeywordSearchResults>> getKeywordList({
    required String? searchTerm,
    required int offset,
    required int limit,
  });
}

class PicklistKeywordDataSource implements IPicklistKeywordDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  PicklistKeywordDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, PicklistKeywordSearchResults>> getKeywordList({
    required String? searchTerm,
    required int offset,
    required int limit,
  }) async =>
      ExceptionHandler<PicklistKeywordSearchResults>(() async {
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
              endPoint: '/api/v1/picklist/keyword',
              queryParams: queryParams,
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final results = PicklistKeywordSearchResults.fromJsonDto(data);

            return Right(results);
          },
        );
      })();
}

class PicklistKeywordSearchResults {
  final int totalRecords;
  final List<PicklistKeywordModel> keywords;

  PicklistKeywordSearchResults({
    required this.totalRecords,
    required this.keywords,
  });

  factory PicklistKeywordSearchResults.fromJsonDto(
    Map<String, dynamic> dto,
  ) {
    return PicklistKeywordSearchResults(
      totalRecords: dto['total_records'] as int,
      keywords: (dto['keywords'] as List?)
              ?.map(
                (_) => PicklistKeywordModel.fromJsonDto(
                  _,
                ),
              )
              .toList() ??
          [],
    );
  }
}
