// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:evently/firebase/firebase_manager.dart';
// import 'package:evently/models/userModel.dart';
//
// class UserProvider extends ChangeNotifier {
//   UserModel? userModel;
//   User? currentUser;
//
//   UserProvider() {
//     currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       initUser();
//     }
//   }
//
//   initUser() async {
//     currentUser = FirebaseAuth.instance.currentUser;
//     userModel = await FirebaseManager.readUserData(currentUser!.uid);
//     notifyListeners();
//   }
// }
import 'package:evently/firebase/firebase_manager.dart';
import 'package:evently/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  User? currentUser;

  UserProvider() {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      initUser();
    }
  }

  // Future<void> initUser() async {
  //   currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     userModel = await FirebaseManager.readUserData(currentUser!.uid);
  //     notifyListeners();
  //   }
  // }
  Future<void> initUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userModel = await FirebaseManager.readUserData(currentUser!.uid);
      print("User Name Loaded: ${userModel?.name}");
      notifyListeners();
    }
  }




  Future<void> refreshUser() async {
    await initUser();
  }
}
