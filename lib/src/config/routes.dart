import 'package:flutter/material.dart';
import 'package:jb_notify/src/screens/authentication/login_screen.dart';
import 'package:jb_notify/src/screens/faculty_screen.dart';
import 'package:jb_notify/src/screens/navigation_screen.dart';
import 'package:jb_notify/src/screens/push_notice.dart';
import 'package:jb_notify/src/screens/students_parents_screen.dart';

var routes = <String, WidgetBuilder>{
  '/navigation': (context) => const NavigationScreen(),
  '/students_parents_screen': (context) => const StudentsParentsScreen(),
  '/facutly_screen': (context) => const FacultyScreen(),
  '/push_notice': (context) => const PushNotice(),
  '/login_screen': (context) => const LoginScreen(),
};
