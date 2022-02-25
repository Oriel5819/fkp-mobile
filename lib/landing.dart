import 'package:fkpmobile/login.dart';
import 'package:fkpmobile/pages/home.dart';
import 'package:fkpmobile/pages/me.dart';
import 'package:fkpmobile/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;
  PageController pageCtrlr = PageController();

  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageCtrlr.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    checkToken();
    return Scaffold(
      body: PageView(
        controller: pageCtrlr,
        children: const [Home(), Search(), Me()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me')
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
    );
  }
}
