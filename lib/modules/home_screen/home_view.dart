import 'package:chat_own/base_class.dart';
import 'package:chat_own/modules/add_room/add_room_view.dart';
import 'package:chat_own/modules/home_screen/home_navigator.dart';
import 'package:chat_own/modules/home_screen/home_viewmodel.dart';
import 'package:chat_own/modules/home_screen/room_widget.dart';
import 'package:chat_own/modules/login_screen/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.readRooms();
    viewModel.navigator = this;

  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Chat-App"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                icon: const Icon(Icons.logout))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(children: [
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/main_background_img_triangles.png",
                ),
                Positioned(
                  top: mediaQuery.size.height*0.05,
                  child: Consumer<HomeViewModel>(
                    builder: (context, homeViewModel, child) {
                      return SizedBox(width: mediaQuery.size.width,
                        height: mediaQuery.size.height,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: viewModel.rooms.isEmpty ? const Center(
                            child: Text("No Rooms Are Added"),
                          ):GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 1 / 1.5),
                            itemCount: viewModel.rooms.length,
                            itemBuilder: (context, index) {
                              return RoomWidget(viewModel.rooms[index]);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),

        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoomScreen.routeName);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
