import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

  Future<Either<Failure, List<AssetImportSessionModel>>> getSessionList();

  Future<Either<Failure, Empty>> removeSessionFile({
    required String sessionID,
    required String fileID,
  });

  Future<Either<Failure, AssetImportSessionFileMetaModel>> setSessionFileMeta({
    required String sessionID,
    required String fileID,
    required AssetImportSessionFileMetaModel meta,
  });

  Future<Either<Failure, AssetImportSessionFileModel>> uploadSessionFile({
    required String sessionID,
    required String fileName,
    required int fileSize,
    required Uint8List fileData,
    required String mimeType,
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

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final model = AssetImportSessionModel.fromJsonDto(data);

            return Right(model);
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
              endPoint: '/api/v1/asset/import/session/$sessionID/finalize',
            );

            if (response.statusCode != HttpStatus.accepted) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            return const Right(Empty());
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

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final model = AssetImportSessionDetailsModel.fromJsonDto(data);

            return Right(model);
          },
        );
      })();

  @override
  Future<Either<Failure, List<AssetImportSessionModel>>>
      getSessionList() async =>
          ExceptionHandler<List<AssetImportSessionModel>>(() async {
            final response = await _auth.getAuthToken();

            return response.fold(
              (failure) => Left(failure),
              (authToken) async {
                final response = await _client.get(
                  authToken: authToken,
                  endPoint: '/api/v1/asset/import/session/list',
                );

                if (response.statusCode != HttpStatus.ok) {
                  return Left(
                    HttpFailure.fromResponse(response),
                  );
                }

                final data = json.decode(response.body);
                final sessions = (data as List?)
                        ?.map(
                          (_) => AssetImportSessionModel.fromJsonDto(
                            _,
                          ),
                        )
                        .toList() ??
                    [];

                return Right(sessions);
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
  Future<Either<Failure, AssetImportSessionFileMetaModel>> setSessionFileMeta({
    required String sessionID,
    required String fileID,
    required AssetImportSessionFileMetaModel meta,
  }) async =>
      ExceptionHandler<AssetImportSessionFileMetaModel>(() async {
        final response = await _auth.getAuthToken();

        return response.fold(
          (failure) => Left(failure),
          (authToken) async {
            final response = await _client.put(
              authToken: authToken,
              endPoint: '/api/v1/asset/import/session/$sessionID/file/$fileID',
              body: json.encode(meta.toJsonDto()),
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                HttpFailure.fromResponse(response),
              );
            }

            final data = json.decode(response.body);
            final model = AssetImportSessionFileMetaModel.fromJsonDto(data);

            return Right(model);
          },
        );
      })();

  @override
  Future<Either<Failure, AssetImportSessionFileModel>> uploadSessionFile({
    required String sessionID,
    required String fileName,
    required int fileSize,
    required Uint8List fileData,
    required String mimeType,
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
              fileSize: fileSize,
              fileData: fileData,
              mimeType: mimeType,
            );

            if (response.statusCode != HttpStatus.ok) {
              return Left(
                await HttpFailure.fromStreamedResponse(response),
              );
            }

            final body = await response.stream.bytesToString();
            final data = json.decode(body);
            final model = AssetImportSessionFileModel.fromJsonDto(data);

            return Right(model);
          },
        );
      })();
}
