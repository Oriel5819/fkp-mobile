import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

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
                  hintText: 'Name',
                ),
                controller: _name,
              ),
              const SizedBox(
                height: 20,
              ),
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
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirm password',
                ),
                controller: _confirmPassword,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(
                        AuthenticationRegisterEvent(_name.text, _email.text,
                            _password.text, _confirmPassword.text));
                  },
                  child: const Text("Register")),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(const AuthenticationWannaLoginInEvent());
                  },
                  child: const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
