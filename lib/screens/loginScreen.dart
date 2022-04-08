import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/screens/functions/snackBarMessenger.dart';
import 'package:fkpmobile/screens/landingScreen.dart';
import 'package:fkpmobile/screens/registerScreen.dart';
import 'package:fkpmobile/screens/widgets/textFields/email.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fkpmobile/constants/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late bool _registration = false;

  @override
  Widget build(BuildContext context) {
    // open keyboard
    final bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state.isLoading == true) {
          SnackBarMessenger(context, "Please wait...");
        }
        if (state is AuthenticationLoggedInSuccessState &&
            state.isLoading == false) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          bool userId = (await localStorage.setString("userID", state.id));
          bool userFirstName =
              (await localStorage.setString("userFirstName", state.firstname));
          bool userLastName =
              (await localStorage.setString("userLastName", state.lastname));
          bool userEmail =
              (await localStorage.setString("userEmail", state.email));
          bool userToken =
              (await localStorage.setString("userToken", state.token));

          if (userId &&
              userFirstName &&
              userLastName &&
              userEmail &&
              userToken) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LANDING, (route) => false);
          }
        }
        if (state is AuthenticationLoggedInFailState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          SnackBarMessenger(context, state.errorMessage.toString());
        }
        if (state is AuthenticationWannaRegisterState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(REGISTER, (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthenticationWannaRegisterState) {}
        if (state is AuthenticationLoggedInSuccessState) {
          return const Scaffold(
            body: Center(child: Text("Logged In")),
          );
        }
        if (state is AuthenticationLoginingState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: secondary,
                  ),
                  SizedBox(height: 20),
                  Text("Login...")
                ],
              ),
            ),
          );
        } else if (state is AuthenticationLoggedOutState &&
                state.isLoading == false ||
            state is AuthenticationWannaLoginState ||
            state is AuthenticationLoggedInFailState) {
          return GestureDetector(
            onDoubleTap: () {
              setState(() {
                _registration = !_registration;
              });
            },
            child: Scaffold(
              body: Form(
                key: _formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // string with onchange and controller with texteditingController
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter an email";
                            } else if (value.length < 10) {
                              return "A name contents must be at least 10 characters";
                            } else if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Please a valid Email';
                            }
                          },
                          decoration: const InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-z0-9.@_-]")),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password.';
                            }
                            if (value.length < 8) {
                              return 'Password content longer must be at least 8 characters.';
                            }
                            if (value.length > 16) {
                              return 'Password content longer must not be more than 16 characters.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'Password',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9-_~@/.]")),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        if (!_registration)
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthenticationBloc>().add(
                                    AuthenticationLoginEvent(
                                        email: _email.text,
                                        password: _password.text));
                              }
                            },
                            child: const Text("Login"),
                            style: ElevatedButton.styleFrom(
                              primary: secondary,
                              onPrimary: Colors.white,
                              minimumSize: const Size(500, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        if (_registration)
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthenticationBloc>().add(
                                    AuthenticationWannaRegisterEvent(
                                        email: _email.text,
                                        password: _password.text));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: secondary,
                              minimumSize: const Size(500, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                            child: const Text(
                              "Create",
                            ),
                          ),
                        const SizedBox(
                          height: 30,
                        ),
                        if (!_registration)
                          const Text(
                              "Double tap anywhere to create an account"),
                        if (_registration)
                          const Text("Double anywhere tap to login")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is AuthenticationRegisteringState) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: secondary,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Checking user existance...")
              ],
            )),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.toString()),
            ),
          );
        }
      },
    );
  }
}
