import 'package:fkpmobile/blocs/employee/employee_bloc.dart';
import 'package:fkpmobile/models/employee.dart';
import 'package:fkpmobile/screens/landingScreen.dart';
import 'package:fkpmobile/screens/pages/scanPage.dart';
import 'package:fkpmobile/screens/widgets/buttons/popButton.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class ContactPage extends StatefulWidget {
  final Employee employee;
  const ContactPage({Key? key, required this.employee}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ContactPage> createState() => _ContactPageState(employee);
}

class _ContactPageState extends State<ContactPage> {
  final Employee employee;
  _ContactPageState(this.employee);
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _descriptions;

  void _addOrdonancia() {
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        builder: (context) {
          return Form(
            key: _formKey,
            child: Container(
                color: const Color(0xFF737373),
                height: 1000,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                                child: IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      print(_title);
                                      print(_descriptions);
                                      Navigator.pop(context);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: secondary,
                                    size: 16,
                                  ),
                                ),
                              ),
                              const Text("To do"),
                              const PopButton()
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              TextFormField(
                                autofocus: true,
                                onChanged: (value) {
                                  _title = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter a title";
                                  }
                                  if (value.length < 3) {
                                    return "A name contents must be at least 3 characters";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  // border: OutlineInputBorder(),
                                  hintText: 'Title',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                minLines: 3,
                                maxLines: 10,
                                onChanged: (value) {
                                  _descriptions = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter a description";
                                  }
                                  if (value.length < 3) {
                                    return "A name contents must be at least 3 characters";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  // border: OutlineInputBorder(),
                                  hintText: 'Descriptions',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        title: Text(employee.firstName),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondary,
        onPressed: () => _addOrdonancia(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
