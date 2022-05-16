part of 'firebase_sign_in_cubit.dart';

@immutable
abstract class FirebaseSignInState {}

class FirebaseSignInInitial extends FirebaseSignInState {}

class FirebaseSignInLoading extends FirebaseSignInState {}

class FirebaseSignInSuccess extends FirebaseSignInState {
  final User? user;
  FirebaseSignInSuccess({required this.user});
  List<Object> get props => [user!];
}

class FirebaseSignInFailure extends FirebaseSignInState {
  final String message;
  FirebaseSignInFailure({required this.message});

  List<Object> get props => [message];
}

class FirebaseSignInError extends FirebaseSignInState {
  final String message;
  FirebaseSignInError({required this.message});

  List<Object> get props => [message];
}
