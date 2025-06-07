import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently/base.dart';
import 'package:evently/login/login_connector.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {
  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      connector!.showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      connector!.showError(message: e.message ?? "");
    }
  }
  Future<void> loginWithGoogle() async {
    try {
      connector!.showLoading();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // لو المستخدم لغى تسجيل الدخول
        connector!.hideLoading();
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      connector!.hideLoading();
      connector!.goToHome();
    } catch (e) {
      connector!.hideLoading();
      connector!.showError(message: e.toString());
    }
  }

}
