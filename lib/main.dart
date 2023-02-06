import 'package:chat_own/firebase_options.dart';
import 'package:chat_own/modules/create_account/create_account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
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
      initialRoute: CreateAccountScreen.routeName,
      routes: {
        CreateAccountScreen.routeName:(context) => CreateAccountScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}