import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/user.dart';
import 'package:chat_own/modules/create_account/create_account_navigator.dart';
import 'package:chat_own/shared/components/firebase_error_codes.dart';
import 'package:chat_own/shared/network/cloud_firestore_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountViewModel extends BaseViewModel<CreateAccountNavigator> {
  bool _obscurePassword = true;
  bool isLoading = false;

  void changePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  bool get getObscurePassword {
    return _obscurePassword;
  }

  late String message;

  void createAccountWithFirebaseAuth(
      {required String email,
      required String password,
      required String firstName,
      required String userName}) async {
    try {
      navigator.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = "account created, you can login now";
      //Add Data To Database
      UserModel userModel = UserModel(
          id: credential.user?.uid,
          firstName: firstName,
          userName: userName,
          email: email);
       CloudFirestoreUtils.addUserToDatabase(userModel).then((value) => navigator.goToHome(userModel));
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrorCodes.weakPassword) {
        message = "The password provided is too weak.";
      } else if (e.code == FirebaseErrorCodes.emailInUse) {
        message = "account already exists for this email";
      }
    } catch (e) {
      message = "e.toString()";
    }
    navigator.hideDialog();
    navigator.showMessage(message);
  }
}
