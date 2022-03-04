import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/screens/homeScreen.dart';
import 'package:fkpmobile/services/authenticationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthenticationBloc>(
        create: (context) =>
            AuthenticationBloc(authProvider: AuthenticationService()),
        child: const HomeScreen(),
      )));
}
