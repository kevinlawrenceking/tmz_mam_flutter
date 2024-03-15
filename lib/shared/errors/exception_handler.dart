import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

class ExceptionHandler<TResult> {
  final Future<Either<Failure, TResult>> Function() func;

  const ExceptionHandler(this.func);

  Future<Either<Failure, TResult>> call() async {
    try {
      return await func();
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
