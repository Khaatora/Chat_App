import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/models/message.dart';
import 'package:chat_own/models/user.dart';
import 'package:chat_own/modules/chat_screen/chat_room_navigator.dart';
import 'package:chat_own/network/remote/cloud_firestore_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator>  {
  late ChatRoomModel chatRoomModel;
  late UserModel user;

  void sendMessage(String content) {
    CloudFirestoreUtils.addMessageToDatabase(MessageModel(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        roomId: chatRoomModel.id!,
        senderId: user.id!,
        senderName: user.firstName!)).then((value) {
          navigator.resetMessageFormField();
        },);
  }

  Stream<QuerySnapshot<MessageModel>> getMessages(){
    return CloudFirestoreUtils.readMessagesFromFirestoreAsStream(chatRoomModel.id!);
  }
}
