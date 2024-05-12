import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/picklist_celebrity.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IPicklistCelebrityDataSource {
  Future<Either<Failure, PicklistCelebritySearchResults>> getCelebrityList({
    required String? searchTerm,
    required int offset,
    required int limit,
  });
}

class PicklistCelebrityDataSource implements IPicklistCelebrityDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  PicklistCelebrityDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, PicklistCelebritySearchResults>> getCelebrityList({
    required String? searchTerm,
    required int offset,
    required int limit,
  }) async =>
      ExceptionHandler<PicklistCelebritySearchResults>(() async {
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
              endPoint: '/api/v1/picklist/celebrity',
              queryParams: queryParams,
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final results = PicklistCelebritySearchResults.fromJsonDto(data);

            return Right(results);
          },
        );
      })();
}

class PicklistCelebritySearchResults {
  final int totalRecords;
  final List<PicklistCelebrityModel> celebrities;

  PicklistCelebritySearchResults({
    required this.totalRecords,
    required this.celebrities,
  });

  factory PicklistCelebritySearchResults.fromJsonDto(
    Map<String, dynamic> dto,
  ) {
    return PicklistCelebritySearchResults(
      totalRecords: dto['total_records'] as int,
      celebrities: (dto['celebrities'] as List?)
              ?.map(
                (_) => PicklistCelebrityModel.fromJsonDto(
                  _,
                ),
              )
              .toList() ??
          [],
    );
  }
}
