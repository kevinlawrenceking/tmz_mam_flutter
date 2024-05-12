import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'http_failure.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure() : super('');
}

class GeneralFailure extends Failure {
  const GeneralFailure({String? message}) : super(message ?? '');
}

class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure() : super('');
}
