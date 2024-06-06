part of 'auth_session_bloc.dart';

@immutable
abstract class AuthSessionBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthSessionBlocState {}

class ResetState extends AuthSessionBlocState {}

class SessionExpiredState extends AuthSessionBlocState {}

class UserLoggedOutState extends AuthSessionBlocState {}
