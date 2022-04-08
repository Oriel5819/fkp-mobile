import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/constants/constant.dart';
import 'package:fkpmobile/screens/functions/snackBarMessenger.dart';
import 'package:fkpmobile/screens/loginScreen.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state.isLoading == true) {
          SnackBarMessenger(context, "Please wait...");
        }
        if (state is AuthenticationWannaLoginState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LOGIN, (route) => false);
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
      },
      builder: (context, state) {
        // open keyboard
        final bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

        if (state is AuthenticationWannaRegisterState) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isKeyBoard)
                        IconButton(
                            onPressed: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(const AuthenticationWannaLoginInEvent());
                            },
                            icon: const Icon(
                              Icons.close,
                              color: secondary,
                            )),
                      if (!isKeyBoard)
                        const SizedBox(
                          height: 20,
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(),
                                hintText: 'First Name',
                              ),
                              controller: _fname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a first name";
                                }
                                if (value.length < 3) {
                                  return "A name contents must be at least 3 characters";
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(),
                                hintText: 'Last Name',
                              ),
                              controller: _lname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a last name";
                                }
                                if (value.length < 3) {
                                  return "A name contents must be at least 3 characters";
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(),
                          hintText: 'Confirm password',
                        ),
                        controller: _confirmPassword,
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
                          if (value != state.password) {
                            return "Password and confirm password must match.";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9-_~@/.]")),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (state.password == _confirmPassword.text) {
                                  context.read<AuthenticationBloc>().add(
                                      AuthenticationRegisterEvent(
                                          fname: _fname.text,
                                          lname: _lname.text,
                                          email: state.email,
                                          password: state.password,
                                          confirmPassword:
                                              _confirmPassword.text));
                                }
                              }
                            },
                            child: const Text("Save"),
                            style: ElevatedButton.styleFrom(
                                primary: secondary,
                                onPrimary: Colors.white,
                                minimumSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state is AuthenticationRegisteringState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: secondary,
                  ),
                  SizedBox(height: 20),
                  Text("Registering...")
                ],
              ),
            ),
          );
        } else if (state is AuthenticationLoggedInSuccessState) {
          return Scaffold(
            body: Center(
              child: Column(
                children: const [
                  Icon(Icons.done),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Registered"),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(state.toString()),
            ),
          );
        }
      },
    );
  }
}
