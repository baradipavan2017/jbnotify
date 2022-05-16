import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jb_notify/src/config/api_constants.dart';
import 'package:jb_notify/src/model/notice_model.dart';
import 'package:jb_notify/src/widgets/notice_list_tile.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<Notice>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text('Unable to fetch data ${snapshot.hasError}'),
              );
            }else if(snapshot.hasData){
              final user = snapshot.data!;
              return ListView(
                children: user.map(buildNotice).toList(),
              );
            }else{
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
  Widget buildNotice(Notice notice) => NoticeListTile(
    title: notice.title,
    description: notice.description,
    dateTime: notice.dateTime,
    url: notice.url,
    docUrl: notice.documentUrl,
  );

  Stream<List<Notice>> readUsers() => FirebaseFirestore.instance
      .collection(APIConstants.student).orderBy('dateTime',descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Notice.fromJson(doc.data())).toList());
}
