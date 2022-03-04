part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final bool isLoading;
  const AuthenticationState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class AuthenticationWannaRegisterState extends AuthenticationState {
  const AuthenticationWannaRegisterState({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthenticationWannaLoginState extends AuthenticationState {
  const AuthenticationWannaLoginState({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthenticationLoggedInSuccessState extends AuthenticationState {
  const AuthenticationLoggedInSuccessState({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthenticationLoggedInFailState extends AuthenticationState {
  const AuthenticationLoggedInFailState(
      {required bool isLoading, required String errorMessage})
      : super(isLoading: isLoading);
}

class AuthenticationLoggedOutState extends AuthenticationState {
  const AuthenticationLoggedOutState({required bool isLoading})
      : super(isLoading: isLoading);
}
