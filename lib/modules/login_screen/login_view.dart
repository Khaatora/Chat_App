import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/user.dart';
import 'package:chat_own/modules/create_account/create_account_view.dart';
import 'package:chat_own/modules/home_screen/home_view.dart';
import 'package:chat_own/modules/login_screen/login_navigator.dart';
import 'package:chat_own/modules/login_screen/login_view_model.dart';
import 'package:chat_own/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const String routeName = "Login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseView<LoginView, LoginViewModel>
    implements LoginNavigator {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider<LoginViewModel>.value(
        value: viewModel,
        builder: (context, child) {
          bool obscurePassword = context.select<LoginViewModel, bool>(
              (value) => value.getObscurePassword);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Column(children: [
                Image.asset(
                  "assets/images/main_background_img_triangles.png",
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width * 0.03,
                          vertical: mediaQuery.size.height * 0.02),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ------------------- First Name
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: false,
                              validator: (text) {
                                if (text!.trim() == "") {
                                  return "Please Enter Email";
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(text)) {
                                  return "Invalid Email";
                                }
                                return null;
                              },
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ))),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // ------------------- Password
                            TextFormField(
                              controller: passwordController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (text) {
                                if (text!.trim() == "") {
                                  return "Please Enter Valid Password";
                                }
                                return null;
                              },
                              autofocus: false,
                              obscureText: obscurePassword,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    )),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    viewModel.changePasswordVisibility();
                                  },
                                  icon: Icon(obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: validateForm,
                                style: ButtonStyle(
                                    side: MaterialStateBorderSide.resolveWith(
                                        (states) => const BorderSide())),
                                child: const Text("Login")),
                            const SizedBox(
                              height: 5,
                            ),
                            TextButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, CreateAccountView.routeName),
                                child: const Text(
                                    "Don't Have An Account? Click Here!"))
                          ]),
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.loginWithFirebaseAuth(
          emailController.text, passwordController.text);
      unFocusKeyboardFromScope();
    }
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void goToHome(UserModel? userModel) {
    context.read<MyProvider>().setUser = userModel!;
    Navigator.pushNamedAndRemoveUntil(
        context, HomeView.routeName, (route) => false,
        arguments: userModel);
  }

  void unFocusKeyboardFromScope() {
    FocusScope.of(context).unfocus();
  }
}
