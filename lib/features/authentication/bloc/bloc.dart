import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmz_mam_flutter/data/sources/auth.dart';
import 'package:tmz_mam_flutter/shared/errors/failures/failure.dart';

part 'event.dart';
part 'state.dart';

class AuthenticationBloc extends Bloc<BlocEvent, BlocState> {
  final IAuthDataSource authDataSource;

  AuthenticationBloc({
    required this.authDataSource,
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

    final result = await authDataSource.authenticate(
      username: event.username,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthenticationFailureState(failure)),
      (authToken) => emit(AuthenticationSuccessfulState()),
    );
  }
}
