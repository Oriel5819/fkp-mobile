import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/blocs/employee/employee_bloc.dart';
import 'package:fkpmobile/blocs/qrcode/qrcode_bloc.dart';
import 'package:fkpmobile/constants/constant.dart';
import 'package:fkpmobile/screens/landingScreen.dart';
import 'package:fkpmobile/screens/loginScreen.dart';
import 'package:fkpmobile/screens/registerScreen.dart';
import 'package:fkpmobile/services/authenticationService.dart';
import 'package:fkpmobile/services/qrcodeServices.dart';
import 'package:fkpmobile/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  final AuthenticationBloc _authentication =
      AuthenticationBloc(authProvider: AuthenticationService());
  final EmployeeBloc _users = EmployeeBloc(userServices: EmployeeServices());
  final QrcodeBloc _qrcode = QrcodeBloc(qrcodeService: QrcodeService());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      LANDING: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authentication,
              ),
              BlocProvider.value(
                value: _users,
              ),
              BlocProvider.value(
                value: _qrcode,
              ),
            ],
            child: const LandingScreen(),
          ),
      LOGIN: (context) => BlocProvider.value(
            value: _authentication,
            child: const LoginScreen(),
          ),
      REGISTER: (context) => BlocProvider.value(
            value: _authentication,
            child: RegisterScreen(),
          )
    },
    initialRoute: LANDING,
  ));
}
