import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/modules/add_room/add_room_navigator.dart';
import 'package:chat_own/shared/network/cloud_firestore_utils.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {

  late String message;

  void addRoomToDB(
      {required String title,
      required String description,
      required String categoryId}) async {

    navigator.showLoading();
    ChatRoomModel chatRoom = ChatRoomModel(
        title: title, description: description, categoryId: categoryId);
    try {
      await CloudFirestoreUtils.addRoomToDatabase(chatRoom);

      navigator.hideDialog();
      navigator.pop();
      return;
    } catch (e) {
      message = e.toString();
    }
    navigator.hideDialog();
    navigator.showMessage(message);
  }
}
