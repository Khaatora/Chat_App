import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = "Create_Account_Screen";
  bool obscurePassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

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
              key: widget.formKey,
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.03,
                  vertical: mediaQuery.size.height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: (text){
                      if(text!.trim() == ""){
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
                  TextFormField(
                    autofocus: false,
                    textInputAction: TextInputAction.next,
                    validator: (text){
                      if(text!.trim() == ""){
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
                  TextFormField(
                    validator: (text){
                        if(text!.trim() == ""){
                          return "Please Enter Email";
                        }
                      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text)){
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
                  TextFormField(
                    validator: (text){
                      if(text!.trim() == ""){
                        return "Please Enter Valid Password";
                      }
                      return null;
                    },
                    autofocus: false,
                    obscureText: widget.obscurePassword,
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
                            setState(() {
                              widget.obscurePassword = !widget.obscurePassword;
                            });
                          },
                          icon: Icon(widget.obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off),),
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
  }

  void CreateAccount() {
    if(widget.formKey.currentState!.validate()){
      print("hello");
    }
  }
}
