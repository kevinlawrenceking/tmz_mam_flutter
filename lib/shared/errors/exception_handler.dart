import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

class ExceptionHandler<TResult> {
  final Future<Either<Failure, TResult>> Function() func;

  const ExceptionHandler(this.func);

  Future<Either<Failure, TResult>> call() async {
    try {
      return await func();
    } on ClientException catch (e) {
      debugPrint(e.toString());
      return const Left(
        GeneralFailure(
          message: 'Request failed. Service may be unavailable.',
        ),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Left(
        GeneralFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
