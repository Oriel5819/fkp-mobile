part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final bool isLoading;

  const AuthenticationState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class AuthenticationLoggedOutState extends AuthenticationState {
  const AuthenticationLoggedOutState({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthenticationRegisteringState extends AuthenticationState {
  const AuthenticationRegisteringState({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthenticationLoginingState extends AuthenticationState {
  const AuthenticationLoginingState({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthenticationWannaRegisterState extends AuthenticationState {
  final String email;
  final String password;
  const AuthenticationWannaRegisterState(
      {required bool isLoading, required this.email, required this.password})
      : super(isLoading: isLoading);
}

class AuthenticationWannaLoginState extends AuthenticationState {
  const AuthenticationWannaLoginState({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthenticationLoggedInSuccessState extends AuthenticationState {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String token;
  const AuthenticationLoggedInSuccessState(
      {required bool isLoading,
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.token})
      : super(isLoading: isLoading);
}

class AuthenticationLoggedInFailState extends AuthenticationState {
  final String? errorMessage;
  const AuthenticationLoggedInFailState(
      {required bool isLoading, required this.errorMessage})
      : super(isLoading: isLoading);
}
