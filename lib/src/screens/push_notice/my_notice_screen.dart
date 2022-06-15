import 'package:flutter/material.dart';
import 'package:jb_notify/src/screens/push_notice/my_notice_students.dart';
import 'my_notice_faculty.dart';

class MyNoticeScreen extends StatelessWidget {
  const MyNoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Notices'),
          bottom: const TabBar(tabs: <Widget>[
            Tab(
              text: 'Student',
            ),
            Tab(
              text: 'Faculty',
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/push_notice');
          },
          child: const Icon(Icons.add),
        ),
        body:  TabBarView(
          children: <Widget>[
            MyNoticeStudents(),
            MyNoticeFaculty(),
          ],
        ),
      ),
    );
  }
}
