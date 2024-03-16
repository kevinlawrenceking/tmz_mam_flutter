import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tmz_damz/data/models/asset_import_session.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/data/providers/rest_client.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/empty.dart';
import 'package:tmz_damz/shared/errors/exception_handler.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

abstract class IAssetImportSessionDataSource {
  Future<Either<Failure, AssetImportSessionModel>> createSession();

  Future<Either<Failure, Empty>> finalizeSession({
    required String sessionID,
  });

  Future<Either<Failure, AssetImportSessionDetailsModel>> getSessionDetails({
    required String sessionID,
  });

  Future<Either<Failure, Empty>> removeSessionFile({
    required String sessionID,
    required String fileID,
  });

  Future<Either<Failure, AssetImportSessionFileModel>> uploadSessionFile({
    required String sessionID,
    required String fileName,
    required Stream<List<int>> fileStream,
    required int fileSize,
  });
}

class AssetImportSessionDataSource implements IAssetImportSessionDataSource {
  final IAuthDataSource _auth;
  final IRestClient _client;

  AssetImportSessionDataSource({
    required IAuthDataSource auth,
    required IRestClient client,
  })  : _auth = auth,
        _client = client;

  @override
  Future<Either<Failure, AssetImportSessionModel>> createSession() async =>
      ExceptionHandler<AssetImportSessionModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/asset/import/session',
            );

            if (response.statusCode == HttpStatus.ok) {
              final data = json.decode(response.body);
              final session = AssetImportSessionModel.fromJsonDto(data);
              return Right(session);
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
  Future<Either<Failure, Empty>> finalizeSession({
    required String sessionID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.post(
              authToken: authToken,
              endPoint: '/api/v1/asset/import/session/$sessionID',
            );

            if (response.statusCode == HttpStatus.accepted) {
              return const Right(Empty());
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
  Future<Either<Failure, AssetImportSessionDetailsModel>> getSessionDetails({
    required String sessionID,
  }) async =>
      ExceptionHandler<AssetImportSessionDetailsModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.get(
              authToken: authToken,
              endPoint: '/api/v1/asset/import/session/$sessionID/details',
            );

            if (response.statusCode == HttpStatus.ok) {
              final data = json.decode(response.body);
              final session = AssetImportSessionDetailsModel.fromJsonDto(data);
              return Right(session);
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
  Future<Either<Failure, Empty>> removeSessionFile({
    required String sessionID,
    required String fileID,
  }) async =>
      ExceptionHandler<Empty>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.delete(
              authToken: authToken,
              endPoint: '/api/v1/asset/import/session/$sessionID/file/$fileID',
            );

            if (response.statusCode == HttpStatus.ok) {
              return const Right(Empty());
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
  Future<Either<Failure, AssetImportSessionFileModel>> uploadSessionFile({
    required String sessionID,
    required String fileName,
    required Stream<List<int>> fileStream,
    required int fileSize,
  }) async =>
      ExceptionHandler<AssetImportSessionFileModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.sendFile(
              authToken: authToken,
              endPoint: '/api/v1/asset/import/session/$sessionID/upload',
              fileName: fileName,
              fileStream: fileStream,
              fileSize: fileSize,
            );

            if (response.statusCode == HttpStatus.ok) {
              final body = await response.stream.bytesToString();
              final data = json.decode(body);
              final asset = AssetImportSessionFileModel.fromJsonDto(data);
              return Right(asset);
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
