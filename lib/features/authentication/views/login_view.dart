import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_mam_flutter/app_router.gr.dart';
import 'package:tmz_mam_flutter/features/authentication/bloc/bloc.dart';
import 'package:tmz_mam_flutter/shared/widgets/toast.dart';

@RoutePage(name: 'AuthenticationLoginRoute')
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color(0xFF232323),
        child: BlocProvider<AuthenticationBloc>(
          create: (context) => GetIt.instance<AuthenticationBloc>(),
          child: BlocListener<AuthenticationBloc, BlocState>(
            listener: (context, state) {
              if (state is AuthenticationFailureState) {
                Toast.showNotification(
                  showDuration: const Duration(seconds: 5),
                  type: ToastTypeEnum.error,
                  title: 'Authentication Failure',
                  message: state.failure.message,
                );
              } else if (state is AuthenticationSuccessfulState) {
                AutoRouter.of(context).replace(const AssetsSearchRoute());
              }
            },
            child: BlocBuilder<AuthenticationBloc, BlocState>(
              builder: (context, state) {
                final enabled = state is! AuthenticatingState;

                return Center(
                  child: Container(
                    width: 600,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80.0,
                      vertical: 48.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0x2AFFFFFF),
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0.0, 3.0),
                          blurRadius: 5.0,
                          color: Color(0x0F000000),
                        ),
                        BoxShadow(
                          offset: Offset(0.0, 7.0),
                          blurRadius: 9.0,
                          color: Color(0x1F000000),
                        ),
                        BoxShadow(
                          offset: Offset(0.0, 20.0),
                          blurRadius: 25.0,
                          spreadRadius: -8.0,
                          color: Color(0x2E000000),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6D0000),
                          Color(0xFF8F0D0D),
                          Color(0xFF5C0000),
                        ],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/tmz_logo_dark.png',
                          color: Colors.black,
                          height: 60.0,
                        ),
                        const SizedBox(height: 24.0),
                        const Center(
                          child: Text(
                            'PHOTO MAM',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48.0),
                        _buildUsernameInput(
                          enabled: enabled,
                        ),
                        const SizedBox(height: 32.0),
                        _buildPasswordInput(
                          enabled: enabled,
                        ),
                        const SizedBox(height: 32.0),
                        _buildLoginButton(
                          context: context,
                          enabled: enabled,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required BuildContext context,
    required bool enabled,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 1.0),
            blurRadius: 10.0,
            color: Color(0x1F000000),
          ),
          BoxShadow(
            offset: Offset(0.0, 4.0),
            blurRadius: 5.0,
            color: Color(0x24000000),
          ),
          BoxShadow(
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
            spreadRadius: -1.0,
            color: Color(0x33000000),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6D0000),
            Color(0xFF8F0D0D),
            Color(0xFF5C0000),
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: TextButton(
        onPressed: enabled
            ? () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoginEvent(
                    username: '',
                    password: '',
                  ),
                );
              }
            : null,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0x10FFFFFF);
            } else {
              return Colors.white10;
            }
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) {
              return RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0xFFE81B1B),
                ),
                borderRadius: BorderRadius.circular(6.0),
              );
            },
          ),
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordInput({
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'PASSWORD',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
          enabled: enabled,
          enableSuggestions: false,
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildUsernameInput({
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'USERNAME',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Username',
          ),
          enabled: enabled,
        ),
      ],
    );
  }
}
