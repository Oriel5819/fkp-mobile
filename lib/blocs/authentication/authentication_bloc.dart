import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fkpmobile/models/error.dart';
import 'package:fkpmobile/models/user.dart';
import 'package:fkpmobile/services/authenticationService.dart';
import 'package:http/http.dart' as http;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authProvider;
  AuthenticationBloc({required this.authProvider})
      : super(const AuthenticationLoggedOutState(isLoading: false)) {
    // want to register
    on<AuthenticationWannaRegisterEvent>((event, emit) async {
      emit(const AuthenticationWannaRegisterState(isLoading: false));
    });

    // want to login
    on<AuthenticationWannaLoginInEvent>((event, emit) async {
      emit(const AuthenticationWannaLoginState(isLoading: false));
    });

    // register
    on<AuthenticationRegisterEvent>((event, emit) async {
      // emit(const AuthenticationLoggedOutState(isLoading: true));
      emit(const AuthenticationWannaRegisterState(isLoading: true));
      await authProvider.register(
          event.name, event.email, event.password, event.confirmPassword);
      await authProvider.logIn(event.email, event.password);
      emit(const AuthenticationLoggedInSuccessState(isLoading: false));
    });

    // login
    on<AuthenticationLoginEvent>((event, emit) async {
      emit(const AuthenticationLoggedOutState(isLoading: true));

      // response from API
      http.Response response =
          await authProvider.logIn(event.email, event.password);

      if (response.statusCode == 200) {
        User user = userFromJson(response.body);
        print(user.id);
        emit(const AuthenticationLoggedInSuccessState(isLoading: false));
      } else {
        // when loggin is failed
        Error error = errorFromJson(response.body);
        emit(AuthenticationLoggedInFailState(
            isLoading: false, errorMessage: error.message));
      }
    });

    // logout
    on<AuthenticationLogoutEvent>((event, emit) async {
      emit(const AuthenticationLoggedInSuccessState(isLoading: true));
      await authProvider.logOut();
      emit(const AuthenticationLoggedOutState(isLoading: false));
    });
  }
}
