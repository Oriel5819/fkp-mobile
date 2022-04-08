import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/blocs/employee/employee_bloc.dart';
import 'package:fkpmobile/screens/pages/contactPage.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, authState) {
        // TODO: implement listener
      },
      builder: (context, authState) {
        return BlocConsumer<EmployeeBloc, EmployeeState>(
            listener: (context, employeeState) async {
          // if (state.isLoading == true) {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: const Center(
          //       child: CircularProgressIndicator(
          //         color: secondary,
          //       ),
          //     ),
          //     behavior: SnackBarBehavior.fixed,
          //     shape:
          //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //   ));
          // }
        }, builder: (context, employeeState) {
          if (employeeState.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondary,
              ),
            );
          } else if (authState is AuthenticationLoggedInSuccessState &&
              employeeState is EmployeeFetchSuccessState) {
            return Scaffold(
              body: ListView.builder(
                itemCount: employeeState.allEmployees.length,
                itemBuilder: (BuildContext context, int index) {
                  return (authState.id != employeeState.allEmployees[index].id)
                      ? ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: secondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Center(
                              child: Text(
                                employeeState.allEmployees[index].firstName[0]
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ),
                          title: Text(
                              employeeState.allEmployees[index].firstName
                                      .toString() +
                                  " " +
                                  employeeState.allEmployees[index].lastName
                                      .toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            employeeState.allEmployees[index].email.toString() +
                                "\n" +
                                employeeState.allEmployees[index].contact
                                    .toString(),
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          isThreeLine: true,
                          dense: false,
                          // trailing: const Icon(
                          //   Icons.delete,
                          // ),

                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (newContext) => BlocProvider.value(
                                        value: BlocProvider.of<EmployeeBloc>(
                                            context),
                                        child: ContactPage(
                                            employee: employeeState
                                                .allEmployees[index]),
                                      ))))
                      : const SizedBox(width: 0, height: 0);
                },
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: Text("Some error has occured")),
            );
          }
        });
      },
    );
  }
}
