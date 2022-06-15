import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jb_notify/src/screens/push_notice/my_notice_list_tile.dart';

import '../../config/api_constants.dart';
import '../../model/notice_model.dart';


class MyNoticeStudents extends StatelessWidget {
  MyNoticeStudents({Key? key}) : super(key: key);
  final uID = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Notice>>(
      stream: getFilteredData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Container(
            child: Image.asset("lib/assets/images/no_wifi.png"),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Unable to fetch data ${snapshot.hasError}'),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          print("Account UID --->> ${uID}");
          print(user);
          return ListView(
            children: user.map(buildNotice).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildNotice(Notice notice) => MyNoticeListTile(
        title: notice.title,
        description: notice.description,
        dateTime: notice.dateTime,
        url: notice.url,
        docUrl: notice.documentUrl,
      );

  Stream<List<Notice>> getFilteredData() => FirebaseFirestore.instance
      .collection(APIConstants.student)
      .where("uid", isEqualTo: uID.toString())
      .snapshots()
      .map((event) =>
          event.docs.map((docs) => Notice.fromJson(docs.data())).toList());
}
