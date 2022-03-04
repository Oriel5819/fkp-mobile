import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/screens/loginScreen.dart';
import 'package:fkpmobile/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationLoggedOutState ||
            state is AuthenticationWannaLoginState) {
          return const LoginScreen();
        } else if (state is AuthenticationWannaRegisterState) {
          return RegisterScreen();
        } else if (state is AuthenticationLoggedInSuccessState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You are logged in"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutEvent());
                      },
                      child: const Text("Logout"))
                ],
              ),
            ),
          );
        } else if (state is AuthenticationLoggedInFailState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login error"),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(const AuthenticationWannaLoginInEvent());
                      },
                      child: const Text("Return to login"))
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong..."),
            ),
          );
        }
      },
    );
  }
}
