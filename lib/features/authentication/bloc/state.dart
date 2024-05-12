part of 'bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends BlocState {}

class AuthenticatingState extends BlocState {}

class AuthenticationFailureState extends BlocState {
  final Failure failure;

  AuthenticationFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}

class AuthenticationSuccessfulState extends BlocState {}
