// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
BottomNavigationBar GlobalBottomNavigationBar(
    int _selectedIndex, void Function(int index) onTapped) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      // BottomNavigationBarItem(
      //     icon: Icon(Icons.contacts), label: 'Contacts'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me')
    ],
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.purple,
    unselectedItemColor: Colors.grey,
    onTap: onTapped,
  );
}
