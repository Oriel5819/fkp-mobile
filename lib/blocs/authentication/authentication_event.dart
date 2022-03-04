part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationWannaRegisterEvent extends AuthenticationEvent {
  const AuthenticationWannaRegisterEvent();
}

class AuthenticationWannaLoginInEvent extends AuthenticationEvent {
  const AuthenticationWannaLoginInEvent();
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const AuthenticationRegisterEvent(
      this.name, this.email, this.password, this.confirmPassword);
}

class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationLoginEvent(this.email, this.password);
}

class AuthenticationLogoutEvent extends AuthenticationEvent {}
