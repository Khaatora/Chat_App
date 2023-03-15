import 'package:chat_own/base_class.dart';
import 'package:chat_own/modules/chat_screen/chat_navigator.dart';
import 'package:chat_own/modules/chat_screen/chat_viewmodel.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String routeName = "/chat_screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel> implements ChatNavigator{
  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }
}
