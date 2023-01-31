import 'package:chat_app/database/database_usils.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;

  Future<void> registering(String email, String password, String lastName,
      String firstName, String userName) async {
    try {
      navigator.showLoading();
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save data => store it LOCAL
      MyUser user = MyUser(
          lastName: lastName,
          firstName: firstName,
          email: email,
          id: result.user?.uid ?? '',
          userName: userName);

      var userDate = await DatabaseUsils.registerUser(user);

      navigator.hideLoading();
      navigator.showMessage('Register Done !');
      if (kDebugMode) {
        print('firebase id : ${result.user?.uid}');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMessage('The password provided is too weak.');
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();
        navigator.showMessage('The account already exists for that email.');
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage('Something went wrong !');
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
