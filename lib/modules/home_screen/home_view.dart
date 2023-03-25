import 'package:chat_own/base_class.dart';
import 'package:chat_own/modules/add_room/add_room_view.dart';
import 'package:chat_own/modules/home_screen/home_navigator.dart';
import 'package:chat_own/modules/home_screen/home_viewmodel.dart';
import 'package:chat_own/modules/home_screen/room_widget.dart';
import 'package:chat_own/modules/login_screen/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = "/Home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseView<HomeView, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
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
          title: const Text("Chat-App"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(
                      context, LoginView.routeName);
                },
                icon: const Icon(Icons.logout))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ChangeNotifierProvider.value(
          value: viewModel,
          builder: (context, child) {
            return Column(children: [
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/main_background_img_triangles.png",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight),
                      child: Consumer<HomeViewModel>(
                        builder: (context, homeViewModel, child) {
                          return SizedBox(width: mediaQuery.size.width,
                            height: mediaQuery.size.height,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: StreamBuilder(
                                stream: viewModel.readRoomsAsStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.data==null || snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child:
                                      Text("Something Went Wrong"),
                                    );
                                  }
                                  viewModel.chatlist = snapshot.data!.docs.map((e) => e.data()).toList();
                                  if(viewModel.chatlist.isEmpty){
                                    return const Center(
                                      child: Text("No Rooms Are Added"),
                                    );
                                  }
                                  return GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 1 / 1.5),
                                    itemCount: viewModel.chatlist.length,
                                    itemBuilder: (context, index) {
                                      return RoomWidget(viewModel.chatlist[index]);
                                    },
                                  );
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

            ]);
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoomView.routeName);
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
