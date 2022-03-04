import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                controller: _email,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                controller: _password,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(
                        AuthenticationLoginEvent(_email.text, _password.text));
                  },
                  child: const Text("Login")),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(const AuthenticationWannaRegisterEvent());
                  },
                  child: const Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
