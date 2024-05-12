import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/picklist_agency.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IPicklistAgencyDataSource {
  Future<Either<Failure, PicklistAgencySearchResults>> getAgencyList({
    required String? searchTerm,
    required int offset,
    required int limit,
  });
}

class PicklistAgencyDataSource implements IPicklistAgencyDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  PicklistAgencyDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, PicklistAgencySearchResults>> getAgencyList({
    required String? searchTerm,
    required int offset,
    required int limit,
  }) async =>
      ExceptionHandler<PicklistAgencySearchResults>(() async {
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
              endPoint: '/api/v1/picklist/agency',
              queryParams: queryParams,
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final results = PicklistAgencySearchResults.fromJsonDto(data);

            return Right(results);
          },
        );
      })();
}

class PicklistAgencySearchResults {
  final int totalRecords;
  final List<PicklistAgencyModel> agencies;

  PicklistAgencySearchResults({
    required this.totalRecords,
    required this.agencies,
  });

  factory PicklistAgencySearchResults.fromJsonDto(
    Map<String, dynamic> dto,
  ) {
    return PicklistAgencySearchResults(
      totalRecords: dto['total_records'] as int,
      agencies: (dto['agencies'] as List?)
              ?.map(
                (_) => PicklistAgencyModel.fromJsonDto(
                  _,
                ),
              )
              .toList() ??
          [],
    );
  }
}
