import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/user.dart';

abstract class LoginNavigator extends BaseNavigator{

  void goToHome(UserModel? userModel);

}