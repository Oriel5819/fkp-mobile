// ignore: avoid_web_libraries_in_flutter

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fkpmobile/models/error.dart';
import 'package:fkpmobile/models/user.dart';
import 'package:fkpmobile/services/authenticationService.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authProvider;
  AuthenticationBloc({required this.authProvider})
      : super(const AuthenticationLoggedOutState(isLoading: false)) {
    // want to register
    // check user existance
    on<AuthenticationWannaRegisterEvent>((event, emit) async {
      emit(const AuthenticationRegisteringState(isLoading: true));
      http.Response exist = await authProvider.exist(event.email);
      if (exist.statusCode == 200) {
        emit(AuthenticationWannaRegisterState(
            isLoading: false, email: event.email, password: event.password));
      } else {
        Error error = errorFromJson(exist.body);
        emit(AuthenticationLoggedInFailState(
            isLoading: false, errorMessage: error.message));
      }
    });

    // want to login
    on<AuthenticationWannaLoginInEvent>((event, emit) async {
      emit(const AuthenticationWannaLoginState(isLoading: false));
    });

    // register
    on<AuthenticationRegisterEvent>((event, emit) async {
      emit(const AuthenticationRegisteringState(isLoading: true));
      // register
      http.Response registered = await authProvider.register(event.fname,
          event.lname, event.email, event.password, event.confirmPassword);

      if (registered.statusCode == 201) {
        // login
        http.Response logged =
            await authProvider.logIn(event.email, event.password);

        if (logged.statusCode == 200) {
          User user = userFromJson(logged.body);
          emit(AuthenticationLoggedInSuccessState(
              isLoading: false,
              id: user.id,
              firstname: user.firstName,
              lastname: user.lastName,
              email: user.email,
              token: user.token));
        } else {
          // when loggin is failed
          Error error = errorFromJson(logged.body);
          emit(AuthenticationLoggedInFailState(
              isLoading: false, errorMessage: error.message));
        }
      }
    });

    // login
    on<AuthenticationLoginEvent>((event, emit) async {
      emit(const AuthenticationLoginingState(isLoading: true));

      // response from API
      http.Response response =
          await authProvider.logIn(event.email, event.password);

      if (response.statusCode == 200) {
        User user = userFromJson(response.body);

        emit(AuthenticationLoggedInSuccessState(
            isLoading: false,
            id: user.id,
            firstname: user.firstName,
            lastname: user.lastName,
            email: user.email,
            token: user.token));
      } else {
        // when loggin is failed
        Error error = errorFromJson(response.body);
        emit(AuthenticationLoggedInFailState(
            isLoading: false, errorMessage: error.message));
      }
    });

    // get logged user
    on<AuthenticationStillLoggedInEvent>((event, emit) async {
      emit(AuthenticationLoggedInSuccessState(
          isLoading: false,
          id: event.localStorage.getString("userID")!,
          firstname: event.localStorage.getString("userFirstName")!,
          lastname: event.localStorage.getString("userLastName")!,
          email: event.localStorage.getString("userEmail")!,
          token: event.localStorage.getString("userToken")!));
    });

    // logout
    on<AuthenticationLogoutEvent>((event, emit) async {
      emit(AuthenticationLoggedInSuccessState(
          isLoading: true,
          id: event.id,
          firstname: event.firstname,
          lastname: event.lastname,
          email: event.email,
          token: event.token));
      await authProvider.logOut(event.localStorage);
      emit(const AuthenticationLoggedOutState(isLoading: false));
    });
  }
}
