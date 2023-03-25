import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/modules/chat_screen/chat_room_navigator.dart';
import 'package:chat_own/modules/chat_screen/chat_room_viewmodel.dart';
import 'package:chat_own/modules/chat_screen/message_widget.dart';
import 'package:chat_own/modules/login_screen/login_view.dart';
import 'package:chat_own/providers/my_provider.dart';
import 'package:chat_own/shared/components/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({Key? key}) : super(key: key);
  static const String routeName = "/chat_screen";

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends BaseView<ChatRoomView, ChatViewModel>
    implements ChatNavigator {
  late ChatRoomModel room;
  late TextEditingController messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
    viewModel.navigator = this;
  }

  @override
  void didChangeDependencies() {
    room = ModalRoute.of(context)!.settings.arguments as ChatRoomModel;
    viewModel.chatRoomModel = room;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<MyProvider>();
    viewModel.user = provider.userModel!;
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(room.title!),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                },
                icon: const Icon(Icons.logout))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ChangeNotifierProvider.value(
          value: viewModel,
          builder: (context, child) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/main_background_img_triangles.png",
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: const EdgeInsets.only(top: kToolbarHeight),
                            height: SizeConfig.safeBlockVertical * 80,
                            width: SizeConfig.safeBlockHorizontal * 95,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 12,
                                      spreadRadius: 12,
                                      color: Colors.black26)
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                //message
                                Expanded(
                                  flex: 15,
                                  child: StreamBuilder(
                                    stream: viewModel.getMessages(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                snapshot.error.toString()));
                                      }
                                      var messages = snapshot.data!.docs
                                          .map(
                                              (messageDoc) => messageDoc.data())
                                          .toList();
                                      if (messages.isEmpty) {
                                        return const Center(
                                          child: Text("Send A Message!"),
                                        );
                                      }
                                      return ListView.builder(
                                        itemCount: messages.length,
                                        itemBuilder: (context, index) {
                                          return MessageBox(
                                            message: messages[index],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const Divider(
                                  color: Colors.blue,
                                  indent: 5,
                                  endIndent: 5,
                                  thickness: 1,
                                ),
                                //bottom bar
                                Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        //messageFormField
                                        Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                vertical: SizeConfig
                                                    .blockSizeVertical),
                                            child: TextFormField(
                                              controller: messageController,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(12),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        12))),
                                                hintText: "Type a message",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    12))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //send button
                                        Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                  vertical: SizeConfig
                                                      .blockSizeVertical),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) =>
                                                                    Colors
                                                                        .blue)),
                                                onPressed: () {
                                                  viewModel.sendMessage(
                                                      messageController.text);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    const Text("Send",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    Transform.rotate(
                                                        angle: 60 * -pi / 180,
                                                        origin: Offset
                                                            .fromDirection(
                                                                90 * -pi / 180,
                                                                3),
                                                        child: const Icon(
                                                          Icons.send,
                                                          color: Colors.white,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ))
                                      ],
                                    ))
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  void resetMessageFormField() {
    messageController.clear();
    setState(() {});
  }
}
