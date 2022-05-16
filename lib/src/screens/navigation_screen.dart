import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:jb_notify/src/screens/faculty_screen.dart';
import 'package:jb_notify/src/screens/students_parents_screen.dart';
import 'package:jb_notify/src/screens/test_screen.dart';
import 'package:jb_notify/src/widgets/drawer.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedPageIndex = 0;

  final _pages = [
    StudentsParentsScreen(),
    FacultyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Notices",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromRGBO(92, 135, 212, 1),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AppDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedPageIndex,
        showElevation: false,
        itemCornerRadius: 24,
        curve: Curves.ease,
        onItemSelected: selectPage,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        items: [
          BottomNavyBarItem(
            title: const Text('Student'),
            icon: const Icon(Icons.person_rounded),
            inactiveColor: Colors.black,
            activeColor: Colors.blueGrey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            title: const Text('Faculty'),
            icon: const Icon(Icons.school),
            inactiveColor: Colors.black,
            activeColor: Colors.indigo,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
