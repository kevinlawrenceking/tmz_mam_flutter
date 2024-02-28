import 'package:equatable/equatable.dart';

part 'general_failure.dart';
part 'http_failure.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}
