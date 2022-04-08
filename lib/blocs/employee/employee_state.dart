part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  final bool isLoading;
  const EmployeeState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

// FETCH

class EmployeeFetchState extends EmployeeState {
  const EmployeeFetchState({required bool isLoading})
      : super(isLoading: isLoading);
}

class EmployeeFetchSuccessState extends EmployeeState {
  final List<Employee> allEmployees;
  const EmployeeFetchSuccessState(
      {required bool isLoading, required this.allEmployees})
      : super(isLoading: isLoading);
}

class EmployeeFetchFailState extends EmployeeState {
  final String errorMessage;

  const EmployeeFetchFailState(
      {required bool isLoading, required this.errorMessage})
      : super(isLoading: isLoading);
}

// PROFILE

class EmployeeProfileState extends EmployeeState {
  const EmployeeProfileState({required bool isLoading})
      : super(isLoading: isLoading);
}

class EmployeeProfileSuccess extends EmployeeState {
  // final Employee employee;
  const EmployeeProfileSuccess({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class EmployeeProfileFail extends EmployeeState {
  final String errorMessage;
  const EmployeeProfileFail(
      {required bool isLoading, required this.errorMessage})
      : super(isLoading: isLoading);
}
