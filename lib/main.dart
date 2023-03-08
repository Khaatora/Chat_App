import 'package:chat_own/firebase_options.dart';
import 'package:chat_own/modules/create_account/create_account_view.dart';
import 'package:chat_own/modules/login_screen/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.routeName,
      routes: {
        CreateAccountScreen.routeName:(context) => CreateAccountScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}