import 'package:chat_app/database/database_usils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;

  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  initUser() async {
    if (firebaseUser != null) {
      user = await DatabaseUsils.getUser(firebaseUser?.uid ?? '');
    }
  }
}
