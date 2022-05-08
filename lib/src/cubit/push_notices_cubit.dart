import 'package:bloc/bloc.dart';
import 'package:jb_notify/src/model/notice_model.dart';
import 'package:jb_notify/src/repository/notices_repository.dart';
import 'package:meta/meta.dart';

part 'push_notices_state.dart';

class PushNoticesCubit extends Cubit<NoticesState> {
  PushNoticesCubit({required this.noticeRepositories})
      : super(PushNoticeInitial());
  final NoticeRepositories noticeRepositories;

  Future pushNotice({required Notice notice,required String noticeTo}) async {
    emit(PushNoticeLoading());
    try {
      await noticeRepositories.pushNoticeToDatabase(notice,noticeTo);
      emit(PushNoticeSuccess());
    } catch (e) {
      if (isClosed) {
        close();
      } else {
        print(e.toString());
        emit(
          PushNoticeFailure(
            message: 'Error Unable to push data to database',
          ),
        );
      }
    }
  }

  // Future getNoticeData() async {
  //   emit(GetNoticeDataLoading());
  //   try {
  //     final List<Notice> noticeData = await noticeRepositories.getDataFromDB();
  //     emit(GetNoticeDataSuccess(noticeData: noticeData));
  //   } catch (e) {
  //     if (isClosed) {
  //       close();
  //     } else {
  //       print(e.toString());
  //       emit(
  //         GetNoticeDataFailure(message: 'Error Unable to get data to database'),
  //       );
  //     }
  //   }
  // }
}
