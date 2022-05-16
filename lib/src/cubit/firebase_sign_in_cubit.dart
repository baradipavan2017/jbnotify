import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jb_notify/src/repository/firebase_authentication.dart';
import 'package:meta/meta.dart';

part 'firebase_sign_in_state.dart';

class FirebaseSignInCubit extends Cubit<FirebaseSignInState> {
  FirebaseSignInCubit({required this.authServices})
      : super(FirebaseSignInInitial());

  final AuthenticationServices authServices;

  Future loginWithEmailAndPass(
      {required String email, required String password}) async {
    emit(FirebaseSignInLoading());
    try {
      final user = await authServices.signIn(email: email, password: password);
      emit(FirebaseSignInSuccess(user:  user));
    } on FirebaseAuthException catch (e) {
      emit(FirebaseSignInFailure(message: e.message.toString()));
    } catch (e) {
      if (isClosed) {
        close();
      } else {
        emit(FirebaseSignInError(message: e.toString()));
      }
    }
  }
}
