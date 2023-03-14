import 'package:chat_own/models/user.dart';
import 'package:chat_own/shared/network/cloud_firestore_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  UserModel? userModel;
  User? firebaseUser;

  MyProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null){
      initMyUser();
    }
  }

  void initMyUser()async {
    userModel = await CloudFirestoreUtils.readUserFromDatabase(firebaseUser?.uid);
  }

}