import 'package:chat_own/base_class.dart';
import 'package:chat_own/modules/add_room/add_room_view.dart';
import 'package:chat_own/modules/home_screen/home_navigator.dart';
import 'package:chat_own/modules/home_screen/home_viewmodel.dart';
import 'package:chat_own/modules/login_screen/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName="/Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel> implements HomeNavigator{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat-App"),
        actions: [
          IconButton(onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacementNamed(context, AddRoomScreen.routeName);
      },
      child: const Icon(Icons.add, color: Colors.white,)),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
