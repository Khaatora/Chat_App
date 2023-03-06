import 'package:chat_own/shared/components/firebase_error_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountViewModel extends ChangeNotifier {
  bool obscurePassword = true;
  void changeVisibility(){
    obscurePassword =!obscurePassword;
    notifyListeners();
  }
  void createAccountWithFirebaseAuth(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrorCodes.weakPassword) {
        print('The password provided is too weak.');
      } else if (e.code == FirebaseErrorCodes.emailInUse) {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
