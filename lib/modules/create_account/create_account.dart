import 'package:chat_own/modules/create_account/create_account_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatelessWidget {
  static const String routeName = "Create_Account_Screen";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  CreateAccountViewModel createAccountViewModel = CreateAccountViewModel();


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider(
      create: (context) => createAccountViewModel,
      builder: (context, child) {
        var obscurePassword = context.select<CreateAccountViewModel, bool>(
            (value) => value.obscurePassword);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/main_background_img_triangles.png",
                  ),
                  Positioned(
                      top: mediaQuery.size.height * 0.1,
                      width: mediaQuery.size.width,
                      child: const Center(
                          child: Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white),
                      )))
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
                                  createAccountViewModel.changeVisibility();
                                },
                                icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: CreateAccount,
                              style: ButtonStyle(
                                  side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide())),
                              child: const Text("Create Account")),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  void CreateAccount() {
    if (formKey.currentState!.validate()) {
      createAccountViewModel.createAccountWithFirebaseAuth(
          emailController.text, passwordController.text);
    }
  }
}
