part of 'auth_session_bloc.dart';

@immutable
abstract class AuthSessionBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SessionExpiredEvent extends AuthSessionBlocEvent {
  final String _stateID;

  SessionExpiredEvent() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}

class UserLoggedOutEvent extends AuthSessionBlocEvent {
  final String _stateID;

  UserLoggedOutEvent() : _stateID = const Uuid().v4();

  @override
  List<Object?> get props => [_stateID];
}
