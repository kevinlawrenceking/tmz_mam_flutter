import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'auth_session_bloc_event.dart';
part 'auth_session_bloc_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionBlocEvent, AuthSessionBlocState> {
  AuthSessionBloc() : super(InitialState()) {
    on<SessionExpiredEvent>(_sessionExpiredEvent);
    on<UserLoggedOutEvent>(_userLoggedOutEvent);
  }

  Future<void> _sessionExpiredEvent(
    SessionExpiredEvent event,
    Emitter<AuthSessionBlocState> emit,
  ) async {
    emit(SessionExpiredState());
    emit(ResetState());
  }

  Future<void> _userLoggedOutEvent(
    UserLoggedOutEvent event,
    Emitter<AuthSessionBlocState> emit,
  ) async {
    emit(UserLoggedOutState());
    emit(ResetState());
  }
}
