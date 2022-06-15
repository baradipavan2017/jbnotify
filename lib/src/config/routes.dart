import 'package:flutter/material.dart';
import 'package:jb_notify/src/enums/user_type.dart';
import 'package:jb_notify/src/screens/authentication/login_screen.dart';
import 'package:jb_notify/src/screens/faculty_screen.dart';
import 'package:jb_notify/src/screens/push_notice/my_notice_screen.dart';
import 'package:jb_notify/src/screens/navigation_screen.dart';
import 'package:jb_notify/src/screens/push_notice/push_notice.dart';
import 'package:jb_notify/src/screens/students_parents_screen.dart';
import 'package:jb_notify/src/welcome_screen.dart';

var routes = <String, WidgetBuilder>{
  '/navigation': (context) => const NavigationScreen(userType: UserType.students,),
  '/students_parents_screen': (context) => const StudentsParentsScreen(),
  '/faculty_screen': (context) => const FacultyScreen(),
  '/push_notice': (context) => const PushNotice(),
  '/login_screen': (context) => const LoginScreen(),
  '/my_notice_screen':(context) => const MyNoticeScreen(),
  '/welcome_screen': (context) => WelcomeScreen(),
};
