import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:jb_notify/src/config/api_constants.dart';
import 'package:jb_notify/src/widgets/notice_list_tile.dart';

class StudentsParentsScreen extends StatelessWidget {
  StudentsParentsScreen({Key? key}) : super(key: key);
  final dbRef = FirebaseDatabase.instance.ref().child(APIConstants.student);

  @override
  Widget build(BuildContext context) {
    dbRef.keepSynced(true);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapShot,
              Animation<double> animation, int index) {
            var json = Map<String, dynamic>.from(snapShot.value as Map);
            return NoticeListTile(
              title: json[NoticeConstants.title],
              description: json[NoticeConstants.description],
              dateTime: json[NoticeConstants.dateTime],
              url: json[NoticeConstants.url],
              docUrl: json[NoticeConstants.documentUrl],
            );
          },
        ),
      ),
    );
  }
}
