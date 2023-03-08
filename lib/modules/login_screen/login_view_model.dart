import 'package:chat_own/base_class.dart';
import 'package:chat_own/modules/login_screen/login_navigator.dart';
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
      message = "Successfully Logged In";
    }on FirebaseAuthException{
      message = "Wrong Email Or Password";
    } catch (e) {
      message = "Something Went Wrong";
    }
    navigator.hideDialog();
    navigator.showMessage(message);
  }

}
