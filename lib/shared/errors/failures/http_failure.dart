part of 'failure.dart';

class HttpFailure extends Failure {
  final int statusCode;

  const HttpFailure({
    required this.statusCode,
    String? message,
  }) : super(message ?? '');

  static Failure fromResponse(
    Response response,
  ) {
    ApiError? err;

    try {
      if (response.body.isNotEmpty) {
        final payload = json.decode(response.body) as Map<String, dynamic>?;

        err = ApiError.fromJsonDto(payload?['err']);
      }
    } on Exception {
      // do nothing
    }

    if (err != null) {
      return err;
    } else {
      return HttpFailure(
        statusCode: response.statusCode,
        message: response.reasonPhrase,
      );
    }
  }

  static Future<Failure> fromStreamedResponse(
    StreamedResponse response,
  ) async {
    ApiError? err;

    try {
      final body = await response.stream.bytesToString();

      if (body.isNotEmpty) {
        final payload = json.decode(body) as Map<String, dynamic>?;

        err = ApiError.fromJsonDto(payload?['err']);
      }
    } on Exception {
      // do nothing
    }

    if (err != null) {
      return err;
    } else {
      return HttpFailure(
        statusCode: response.statusCode,
        message: err?.message ?? response.reasonPhrase,
      );
    }
  }
}

class ApiError extends Failure {
  final String code;

  const ApiError({
    required this.code,
    String? message,
  }) : super(message ?? '');

  static ApiError? fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    if (dto == null) {
      return null;
    }

    return ApiError(
      code: dto['code'],
      message: dto['message'],
    );
  }
}
