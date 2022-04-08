import 'package:fkpmobile/api/api.dart';
import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/blocs/employee/employee_bloc.dart';
import 'package:fkpmobile/constants/constant.dart';
import 'package:fkpmobile/models/user.dart';
import 'package:fkpmobile/screens/pages/scanPage.dart';
import 'package:fkpmobile/screens/widgets/buttons/logoutButton.dart';
import 'package:fkpmobile/screens/widgets/buttons/popButton.dart';
import 'package:fkpmobile/screens/widgets/buttons/profileButton.dart';
import 'package:fkpmobile/screens/widgets/images/imageProfile.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userId = "";
    String firstName = "";
    String lastName = "";
    ApiURL apiUrl = ApiURL();

    void _showMyQrode(String id, String firstname, String lastname) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: const Color(0xFF737373),
              height: 320,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            child: IconButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScanCodePage())),
                                icon: const Icon(
                                  Icons.qr_code_scanner,
                                  color: secondary,
                                  size: 16,
                                )),
                          ),
                          Text(
                            firstname + " " + lastname,
                            // "Qr Code",
                            style: const TextStyle(fontSize: 14),
                          ),
                          const PopButton(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          height: 150,
                          width: 150,
                          child:
                              QrImage(data: apiUrl.HEROKU_URI + "users/" + id)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Scan the code"),
                      const SizedBox(
                        height: 20,
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     child: const Center(child: Text("OK")),
                      //     style: TextButton.styleFrom(
                      //         primary: Colors.white,
                      //         backgroundColor: secondary,
                      //         padding:
                      //             const EdgeInsets.symmetric(vertical: 16.0),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(18.0),
                      //         )))
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is AuthenticationLoggedInSuccessState) {
          return Scaffold(
              // appBar: AppBar(
              //   elevation: 0,
              //   title: Text(
              //     state.toString(),
              //     style: const TextStyle(color: Colors.white),
              //   ),
              //   backgroundColor: secondary,
              // ),
              body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageProfile(
                firstName: state.firstname,
                lastName: state.lastname,
                email: state.email,
              ),
              ProfileButton(
                  leftIcon: const Icon(Icons.qr_code),
                  rightIcon: const Icon(Icons.arrow_right),
                  text: "Qr Code",
                  bacgroundColor: Colors.transparent,
                  color: Colors.black,
                  press: () =>
                      _showMyQrode(state.id, state.firstname, state.lastname)),
              ProfileButton(
                leftIcon: const Icon(Icons.settings),
                rightIcon: const Icon(Icons.arrow_right),
                text: "Setting",
                bacgroundColor: Colors.transparent,
                color: Colors.black,
                press: () {},
              ),
              LogoutButton(
                leftIcon: const Icon(Icons.logout),
                text: "Logout",
                bacgroundColor: Colors.transparent,
                color: Colors.red,
                press: () async {
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  var id = localStorage.getString("userID");
                  var firstname = localStorage.getString("userFirstName");
                  var lastname = localStorage.getString("userLastName");
                  var email = localStorage.getString("userEmail");
                  var token = localStorage.getString("userToken");

                  context.read<AuthenticationBloc>().add(
                      AuthenticationLogoutEvent(
                          localStorage: localStorage,
                          id: id.toString(),
                          firstname: firstname.toString(),
                          lastname: lastname.toString(),
                          email: email.toString(),
                          token: token.toString()));
                },
              ),
            ],
          ));
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Profile error"),
            ),
          );
        }
      },
    );
  }
}
