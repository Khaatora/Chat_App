import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/user.dart';
import 'package:chat_own/modules/create_account/create_account_navigator.dart';
import 'package:chat_own/modules/create_account/create_account_viewmodel.dart';
import 'package:chat_own/modules/home_screen/home_view.dart';
import 'package:chat_own/modules/login_screen/login_view.dart';
import 'package:chat_own/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountView extends StatefulWidget {
  static const String routeName = "CreateAccount";

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState
    extends BaseView<CreateAccountView, CreateAccountViewModel>
    implements CreateAccountNavigator {
  late GlobalKey<FormState> formKey;

  late TextEditingController emailController = TextEditingController();

  late TextEditingController passwordController;

  late TextEditingController nameController;

  late TextEditingController userNameController;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    userNameController = TextEditingController();
    viewModel = initViewModel();
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "Create Account",
              style: TextStyle(color: Colors.white),
            ),
              elevation: 0.0,
          ),
          backgroundColor: Colors.white,
          body: ChangeNotifierProvider<CreateAccountViewModel>.value(
            value: viewModel,
            builder: (context, child) {
              var obscurePassword = context.select<CreateAccountViewModel, bool>(
                  (value) => value.getObscurePassword);
              return Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/main_background_img_triangles.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ],
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
                                controller: nameController,
                                validator: (text) {
                                  if (text!.trim() == "") {
                                    return "Please Enter First Name";
                                  }
                                  return null;
                                },
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "First Name",
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
                              // ------------------- User Name
                              TextFormField(
                                controller: userNameController,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                validator: (text) {
                                  if (text!.trim() == "") {
                                    return "Please Enter User Name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "User Name",
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
                              // ------------------- Email Address
                              TextFormField(
                                controller: emailController,
                                validator: (text) {
                                  if (text!.trim() == "") {
                                    return "Please Enter Email";
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(text)) {
                                    return "Please Enter Valid Email";
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
                                validator: (text) {
                                  if (text!.trim() == "") {
                                    return "Please Enter Valid Password";
                                  }
                                  return null;
                                },
                                autofocus: false,
                                obscureText: obscurePassword,
                                autocorrect: false,
                                enableSuggestions: false,
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
                                          (states) => BorderSide())),
                                  child: const Text("Create Account")),
                              const SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                  onPressed: () => Navigator.pushReplacementNamed(
                                      context, LoginView.routeName),
                                  child: const Text(
                                      "Already Have An Account? Click Here!"))
                            ],
                          ),
                        )),
                  ),
                ],
              );
            },
          )),
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.createAccountWithFirebaseAuth(
          email: emailController.text,
          password: passwordController.text,
          userName: userNameController.text,
          firstName: nameController.text);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(UserModel? userModel) {
    context.read<MyProvider>().setUser = userModel!;
    Navigator.pushNamedAndRemoveUntil(
        context, HomeView.routeName, (route) => false,
        arguments: userModel);
  }

}
