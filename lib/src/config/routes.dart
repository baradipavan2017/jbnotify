
import 'package:flutter/material.dart';
import 'package:jb_notify/src/screens/faculty_screen.dart';
import 'package:jb_notify/src/screens/navigation_screen.dart';
import 'package:jb_notify/src/screens/students_parents_screen.dart';


var routes = <String , WidgetBuilder>{
  '/navigation': (context) => NavigationScreen(),
  '/students_parents_screen': (context) => StudentsParentsScreen(),
  '/facutly_screen': (context) => FacultyScreen(),

};