part of 'push_notices_cubit.dart';

@immutable
abstract class NoticesState {}

class PushNoticeInitial extends NoticesState {}

class PushNoticeLoading extends NoticesState {}

class PushNoticeSuccess extends NoticesState {}

class PushNoticeFailure extends NoticesState {
  final String message;
  PushNoticeFailure({required this.message});

  List<Object> get props => [message];
}

class PushNoticeError extends NoticesState {
  final String message;
  PushNoticeError({required this.message});

  List<Object> get props => [message];
}

// class GetNoticeDataInitial extends NoticesState {}
//
// class GetNoticeDataLoading extends NoticesState {}
//
// class GetNoticeDataSuccess extends NoticesState {
//   final List<Notice> noticeData;
//   GetNoticeDataSuccess({required this.noticeData});
//
//   @override
//   List<Object> get props => [noticeData];
// }
//
// class GetNoticeDataFailure extends NoticesState {
//   final String message;
//   GetNoticeDataFailure({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }
//
// class GetNoticeDataError extends NoticesState {
//   final String message;
//   GetNoticeDataError({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }
