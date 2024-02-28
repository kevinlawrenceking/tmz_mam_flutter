part of 'failure.dart';

class HttpFailure extends Failure {
  final int statusCode;

  const HttpFailure({
    required this.statusCode,
    String? message,
  }) : super(message ?? '');
}
