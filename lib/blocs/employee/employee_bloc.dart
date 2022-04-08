import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fkpmobile/models/employee.dart';
import 'package:fkpmobile/models/error.dart';
import 'package:fkpmobile/services/userServices.dart';
import 'package:http/http.dart' as http;

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeServices userServices;
  EmployeeBloc({required this.userServices})
      : super(const EmployeeFetchState(isLoading: false)) {
    on<EmployeeFetchAllEvent>((event, emit) async {
      emit(const EmployeeFetchState(isLoading: true));

      // fetching..
      http.Response response = await userServices.fetchAll(event.token);
      if (response.statusCode == 200) {
        List<Employee> allEmployees = employeeFromJson(response.body);
        emit(EmployeeFetchSuccessState(
            isLoading: false, allEmployees: allEmployees));
      } else {
        Error error = errorFromJson(response.body);
        emit(EmployeeFetchFailState(
            isLoading: false, errorMessage: error.message));
      }

      // emit(const EmployeeLoadingState(isLoading: false));
    });

    on<EmployeeProfileEvent>((event, emit) async {
      emit(const EmployeeProfileState(isLoading: true));
      emit(const EmployeeProfileSuccess(isLoading: false));
    });
  }
}
