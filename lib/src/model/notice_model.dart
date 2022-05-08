
import 'package:jb_notify/src/enums/notice_from.dart';

class Notice {
  final String title;
  final String description;
  final String url;
  final String dateTime;
  final String documentUrl;
  // final NoticeFrom noticefrom;
  Notice({
    required this.title,
    required this.description,
    required this.url,
    required this.dateTime,
    required this.documentUrl,
    // required this.noticefrom,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      dateTime: json['dateTime'] ?? "",
      documentUrl: json['documentUrl'] ?? "",
      // noticefrom: getNoticeFromJsonValue(json['noticefrom'])!,
    );
  }




  static NoticeFrom? getNoticeFromJsonValue(String jsonValue) {
    Map<String, NoticeFrom> map = {
      'ADMIN': NoticeFrom.admin,
      'PRINCIPAL': NoticeFrom.principal,
      'EXAMBRANCH': NoticeFrom.examBranch,
      'FEEPAYMENT': NoticeFrom.feePayment,
      'PLACEMENT': NoticeFrom.placementOfficer,
      'CSE': NoticeFrom.cseHOD,
      'ECE': NoticeFrom.eceHOD,
      'EEE': NoticeFrom.eeeHOD,
      'IT': NoticeFrom.itHOD,
      'CIVIL': NoticeFrom.civilHOD,
      'MECHANICAL': NoticeFrom.mechanicalHOD,
      'ECM': NoticeFrom.ecmHOD,
      'OTHER': NoticeFrom.other,
    };
    return map[jsonValue];
  }
}
