import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/shared/bloc/auth_session_bloc.dart';
import 'package:tmz_damz/shared/errors/failures/failure.dart';

class AuthSessionManager {
  static const kExpirationCheckInterval = Duration(seconds: 15);
  static const kExpirationRefreshWindow = Duration(minutes: 2);

  Timer? _timer;

  final IAuthDataSource authDataSource;
  final AuthSessionBloc authSessionBloc;

  AuthSessionManager({
    required this.authDataSource,
    required this.authSessionBloc,
  });

  Future<void> init() async {
    final result = await authDataSource.getAuthToken();

    result.fold(
      (failure) {},
      (token) => _startTimer(),
    );
  }

  Future<Either<Failure, String>> authenticate({
    required String username,
    required String password,
  }) async {
    _timer?.cancel();
    _timer = null;

    final result = await authDataSource.authenticate(
      username: username,
      password: password,
    );

    result.fold(
      (failure) {},
      (token) => _startTimer(),
    );

    return result;
  }

  Future<void> logout() async {
    _timer?.cancel();
    _timer = null;

    await authDataSource.logout();

    authSessionBloc.add(UserLoggedOutEvent());
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(kExpirationCheckInterval, _timerCallback);
  }

  Future<void> _timerCallback() async {
    final result = await authDataSource.getAuthToken();

    await result.fold(
      (failure) {
        if (failure is SessionExpiredFailure) {
          _handleSessionExpiredEvent();
        }
      },
      (token) async {
        _timer?.cancel();
        _timer = null;

        final remainingTime = JwtDecoder.getRemainingTime(token);

        if (remainingTime < kExpirationRefreshWindow) {
          final result = await authDataSource.refreshToken();

          await result.fold(
            (failure) {
              if (failure is SessionExpiredFailure) {
                _handleSessionExpiredEvent();
              }
            },
            (token) async {
              _startTimer();
            },
          );
        } else {
          _startTimer();
        }
      },
    );
  }

  void _handleSessionExpiredEvent() {
    _timer?.cancel();
    _timer = null;

    authSessionBloc.add(SessionExpiredEvent());
  }
}
