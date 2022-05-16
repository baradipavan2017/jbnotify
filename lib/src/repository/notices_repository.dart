import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:jb_notify/src/model/notice_model.dart';

class NoticeRepositories {
  // final database = FirebaseDatabase.instance.ref();
  final firestoreRef = FirebaseFirestore.instance;

  Future pushNoticeToDatabase(Notice notice, String noticeto) async {
    try {
      await firestoreRef.collection(noticeto).doc().set({
        'title': notice.title,
        'description': notice.description,
        'dateTime': notice.dateTime,
        'url': notice.url,
        'documentUrl': notice.documentUrl,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    // try {
    //   await database.child(noticeto).push().set({
    //     'title': notice.title,
    //     'description': notice.description,
    //     'dateTime': notice.dateTime,
    //     'url': notice.url,
    //     'documentUrl': notice.documentUrl,
    //     // 'noticefrom': notice.noticefrom,
    //   });
    // } catch (e) {
    //   print('error is ' + e.toString());
    // }
  }

}
