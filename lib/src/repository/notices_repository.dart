import 'package:firebase_database/firebase_database.dart';
import 'package:jb_notify/src/model/notice_model.dart';


class NoticeRepositories {
  final database = FirebaseDatabase.instance.ref();

  Future pushNoticeToDatabase(Notice notice,String noticeto) async {
    try {
      await database.child(noticeto).push().set({
        'title': notice.title,
        'description': notice.description,
        'dateTime': notice.dateTime,
        'url': notice.url,
        'documentUrl': notice.documentUrl,
        // 'noticefrom': notice.noticefrom,
      });
    } catch (e) {
      print('error is ' + e.toString());
    }
  }
  
  // Future<List<Notice>> getDataFromDB() async{
  //       List<Notice> noticeData = [];
  //   String url = "https://jb-notifyapp-default-rtdb.asia-southeast1.firebasedatabase.app/notices.json";
  //   final response = await http.get(Uri.parse(url));
  //   print('Response body from repo::::::::::::::');
  //   print(response.body);
  //   List data = json.decode(response.body);
  //   print('list data ::::::::::::');
  //   print(data);
  //   for(Map<String,dynamic> i in data){
  //     Notice _notice = Notice.fromJson(i);
  //     noticeData.add(_notice);
  //   }
  //   print('Notice dataaaa:::::::::');
  //   print(noticeData);
  //  return noticeData;
  // }

}
