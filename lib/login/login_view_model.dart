import 'package:chat_app/database/database_usils.dart';
import 'package:chat_app/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;

  Future<void> loginFirebase(String email, String password) async {
    try {
      navigator.showLoading();
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //navigator.hideLoading();

      var userOpj = await DatabaseUsils.getUser(result.user?.uid ?? '');

      if (userOpj == null) {
        navigator.hideLoading();
        navigator.showMessage('Login FAILED');
      } else {
        navigator.hideLoading();

        navigator.navigateToHome(userOpj);

      }
      //navigator.showMessage('log in successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.hideLoading();
        navigator.showMessage('user-not-found');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.hideLoading();
        navigator.showMessage('wrong-password');
        print('Wrong password provided for that user.');
      }
    }
  }
}
