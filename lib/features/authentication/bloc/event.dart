part of 'bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends BlocEvent {
  final String username;
  final String password;

  LoginEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [
        username,
        password,
      ];
}
