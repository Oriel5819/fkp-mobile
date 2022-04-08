import 'package:fkpmobile/blocs/authentication/authentication_bloc.dart';
import 'package:fkpmobile/blocs/employee/employee_bloc.dart';
import 'package:fkpmobile/blocs/qrcode/qrcode_bloc.dart';
import 'package:fkpmobile/constants/constant.dart';
import 'package:fkpmobile/screens/functions/snackBarMessenger.dart';
import 'package:fkpmobile/screens/methods/Globals/GlobalAppBar.dart';
import 'package:fkpmobile/screens/methods/Globals/GlobalBottomNavigationBar.dart';
import 'package:fkpmobile/screens/pages/homePage.dart';
import 'package:fkpmobile/screens/pages/profilePage.dart';
import 'package:fkpmobile/screens/pages/scanPage.dart';
import 'package:fkpmobile/screens/pages/searchPage.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  String id = "";
  String token = "";

  @override
  void initState() {
    super.initState();
    verifyCredetials();
  }

  void onTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void verifyCredetials() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString("userID") != null &&
        localStorage.getString("userToken") != null) {
      if (mounted) {
        setState(() {
          id = localStorage.getString("userID")!;
          token = localStorage.getString("userToken")!;

          context.read<AuthenticationBloc>().add(
              AuthenticationStillLoggedInEvent(localStorage: localStorage));
          context.read<EmployeeBloc>().add(EmployeeFetchAllEvent(token: token));
        });
      }
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(LOGIN, (route) => false);
    }
  }

  // ignore: non_constant_identifier_names
  PageView GlobalPageView(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (newIndex) {
        if (mounted) {
          setState(() {
            _selectedIndex = newIndex;
          });
        }
      },
      children: [
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
                value: BlocProvider.of<AuthenticationBloc>(context)),
            BlocProvider.value(
              value: BlocProvider.of<EmployeeBloc>(context),
            ),
            // BlocProvider.value(
            //   value: BlocProvider.of<QrcodeBloc>(context),
            // ),
          ],
          child: const HomePage(),
        ),
        // MultiBlocProvider(
        //   providers: [
        //     BlocProvider.value(
        //         value: BlocProvider.of<AuthenticationBloc>(context)),
        //     BlocProvider.value(
        //       value: BlocProvider.of<EmployeeBloc>(context),
        //     ),BlocProvider.value(
        //   value: BlocProvider.of<QrcodeBloc>(context),
        // ),
        //   ],
        //   child: const ContactPage(),
        // ),
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
                value: BlocProvider.of<AuthenticationBloc>(context)),
            BlocProvider.value(
              value: BlocProvider.of<EmployeeBloc>(context),
            ),
            // BlocProvider.value(
            //   value: BlocProvider.of<QrcodeBloc>(context),
            // ),
          ],
          child: const ProfilePage(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (_selectedIndex != 1 && MediaQuery.of(context).viewInsets.bottom != 0) {
    //   FocusManager.instance.primaryFocus?.unfocus();
    // }
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state.isLoading == true) {
          SnackBarMessenger(context, "Please wait...");
        } else if (state is AuthenticationLoggedOutState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          SnackBarMessenger(context, "Logged out");
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LOGIN, (route) => false);
        } else {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      builder: (context, state) {
        if (state is AuthenticationLoggedInSuccessState) {
          return Scaffold(
            appBar: _selectedIndex == 0 ? GlobalAppBar(context, state) : null,
            body: GlobalPageView(context),
            bottomNavigationBar:
                GlobalBottomNavigationBar(_selectedIndex, onTapped),
          );
        } else if (state is AuthenticationLoggedOutState) {
          return const Scaffold(
            body: Center(
              child: Text("Disconnected"),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Error has occured"),
            ),
          );
        }
      },
    );
  }

  // GLOBAL APPBAR
  // ignore: non_constant_identifier_names
  AppBar GlobalAppBar(BuildContext context, AuthenticationState state) {
    if (state is AuthenticationLoggedInSuccessState) {
      return AppBar(
        backgroundColor: secondary,
        title: const Text("Home"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<EmployeeBloc>(context),
                      child: const SearchPage(),
                    ))),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<QrcodeBloc>(context),
                      child: const ScanCodePage(),
                    ))),
            icon: const Icon(Icons.qr_code_scanner),
          ),
        ],
      );
    } else {
      return AppBar(
        title: const Text("Not connected"),
      );
    }
  }
}














































// Scaffold(
//       body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
//         listener: (context, state) {
//           if (state is AuthenticationLoggedOutState &&
//               state.isLoading == false) {
//             Navigator.pop(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         ProfilePage(stateValue: "stateValue")));
//           } else if (state is AuthenticationLoggedInSuccessState) {
//             ScaffoldMessenger.of(context).removeCurrentSnackBar();
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (newContext) => BlocProvider.value(
//                         value: BlocProvider.of<AuthenticationBloc>(context),
//                         child: ProfilePage(stateValue: "yohe"))));
//           }
//           if (state.isLoading == true) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: const Text(
//                 "Please wait...",
//                 textAlign: TextAlign.center,
//               ),
//               padding: const EdgeInsets.all(16.0),
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//             ));
//           } else if (state.errorMessage != null) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text(
//                 state.errorMessage.toString(),
//                 textAlign: TextAlign.center,
//               ),
//               duration: const Duration(seconds: 2),
//               width: 200.0,
//               padding: const EdgeInsets.all(16.0),
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//             ));
//           } else {
//             ScaffoldMessenger.of(context).removeCurrentSnackBar();
//           }
//         },
//         builder: (context, state) {
//           if (state is AuthenticationLoggedOutState ||
//               state is AuthenticationWannaLoginState) {
//             return const LoginScreen();
//           } else if (state is AuthenticationWannaRegisterState) {
//             return RegisterScreen();
//           } else {
//             return const LoginScreen();
//           }
//         },
//       ),
//     );


