import 'package:fkpmobile/blocs/employee/employee_bloc.dart';
import 'package:fkpmobile/models/employee.dart';
import 'package:fkpmobile/screens/landingScreen.dart';
import 'package:fkpmobile/screens/pages/contactPage.dart';
import 'package:fkpmobile/screens/pages/scanPage.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Employee> _foundedEmployees = [];
  var currentFocus;

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is EmployeeFetchSuccessState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: secondary,
              title: SizedBox(
                height: 38,
                child: InputSearch(state),
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _foundedEmployees.length,
              itemBuilder: (BuildContext context, int index) {
                return searchResult(index);
              },
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => const ScanCodePage()));
            //   },
            //   backgroundColor: secondary,
            //   child: const Icon(Icons.qr_code_scanner),
            // ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  TextField InputSearch(EmployeeFetchSuccessState state) {
    return TextField(
      autofocus: true,
      onChanged: ((value) {
        if (value.isEmpty) {
          setState(() {
            _foundedEmployees = [];
          });
        } else {
          setState(() {
            _foundedEmployees = state.allEmployees
                .where((employee) =>
                    employee.firstName.toLowerCase().contains(value))
                .toList();
          });
        }
      }),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade500,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          hintText: "Search name..."),
    );
  }

  ListTile searchResult(int index) {
    return ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: secondary,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Center(
            child: Text(
              _foundedEmployees[index].firstName[0].toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w200),
            ),
          ),
        ),
        title: Text(
          _foundedEmployees[index].firstName.toString() +
              " " +
              _foundedEmployees[index].lastName.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          _foundedEmployees[index].email.toString() +
              "\n" +
              _foundedEmployees[index].contact.toString(),
          style: TextStyle(color: Colors.grey.shade600),
        ),
        isThreeLine: true,
        dense: false,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (newContext) => BlocProvider.value(
                  value: BlocProvider.of<EmployeeBloc>(context),
                  child: ContactPage(employee: _foundedEmployees[index]),
                ))));
  }
}
