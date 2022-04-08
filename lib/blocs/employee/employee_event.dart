part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class EmployeeFetchAllEvent extends EmployeeEvent {
  final String token;

  const EmployeeFetchAllEvent({required this.token});
}

class EmployeeFetchMeEvent extends EmployeeEvent {}

class EmployeeSearchEvent extends EmployeeEvent {}

class EmployeeProfileEvent extends EmployeeEvent {}
