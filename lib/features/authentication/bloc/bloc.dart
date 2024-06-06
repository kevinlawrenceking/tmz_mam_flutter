import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';
import 'package:tmz_damz/utils/auth_session_manager.dart';

part 'event.dart';
part 'state.dart';

class AuthenticationBloc extends Bloc<BlocEvent, BlocState> {
  final AuthSessionManager authSessionManager;

  AuthenticationBloc({
    required this.authSessionManager,
  }) : super(InitialState()) {
    on<LoginEvent>(_loginEvent);
  }

  Future<void> _loginEvent(
    LoginEvent event,
    Emitter<BlocState> emit,
  ) async {
    emit(AuthenticatingState());

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final result = await authSessionManager.authenticate(
      username: event.username,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthenticationFailureState(failure)),
      (authToken) => emit(AuthenticationSuccessfulState()),
    );
  }
}
