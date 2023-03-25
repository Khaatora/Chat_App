import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/user.dart';
import 'package:chat_own/modules/login_screen/login_navigator.dart';
import 'package:chat_own/network/remote/cloud_firestore_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{

  bool _obscurePassword = true;
  bool get getObscurePassword{
    return _obscurePassword;
  }

  void changePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  var auth=FirebaseAuth.instance;
  late String message;

  void loginWithFirebaseAuth(String email, String password) async {
    try {
      navigator.showLoading();
      final credential =
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Read Data from Database
      UserModel? userModel = await CloudFirestoreUtils.readUserFromDatabase(credential.user?.uid);
      print("${userModel?.email}");
      navigator.goToHome(userModel);
      return;
    }on FirebaseAuthException{
      message = "Wrong Email Or Password";
    } catch (e) {
      message = e.toString();
    }
    navigator.hideDialog();
    navigator.showMessage(message);
  }

}
