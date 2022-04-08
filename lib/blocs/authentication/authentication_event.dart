part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationWannaRegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationWannaRegisterEvent(
      {required this.email, required this.password});
}

class AuthenticationWannaLoginInEvent extends AuthenticationEvent {
  const AuthenticationWannaLoginInEvent();
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String confirmPassword;

  const AuthenticationRegisterEvent(
      {required this.fname,
      required this.lname,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationLoginEvent({required this.email, required this.password});
}

class AuthenticationStillLoggedInEvent extends AuthenticationEvent {
  final SharedPreferences localStorage;

  const AuthenticationStillLoggedInEvent({required this.localStorage});
}

class AuthenticationLogoutEvent extends AuthenticationEvent {
  final SharedPreferences localStorage;
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String token;

  const AuthenticationLogoutEvent(
      {required this.localStorage,
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.token});
}
