import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jb_notify/src/config/api_constants.dart';
import 'package:jb_notify/src/cubit/firebase_sign_in_cubit.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  final storage = FlutterSecureStorage();
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential credentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credentials.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw (FirebaseSignInFailure(message: 'User Not Found'));
      } else if (e.code == 'wrong-password') {
        throw (FirebaseSignInFailure(message: 'Wrong Password'));
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await storage.delete(key: 'uid');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> storeToken(UserCredential credential) async {
    await storage.write(
        key: SecureStorageConstants.uid, value: credential.user?.uid);
    await storage.write(
        key: SecureStorageConstants.credentials, value: credential.toString());
  }

  Future<String?> getUID() async {
    return await storage.read(key: SecureStorageConstants.uid);
  }
}
