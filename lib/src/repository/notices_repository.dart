import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        'uid':notice.uid
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

  static UploadTask? uploadFile(
      {required String destination, required File file}) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print('Firebase Api repository error ${e.message.toString()}');
      return null;
    }
  }
}
