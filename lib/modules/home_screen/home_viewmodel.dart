import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/shared/network/cloud_firestore_utils.dart';

import 'home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<ChatRoomModel> rooms = [];

  void readRooms() {
    CloudFirestoreUtils.readRoomsFromFirestore()
        .then((rooms) => this.rooms = rooms)
        .catchError(
      (error) {
        navigator.showMessage(error.toString());
      },
    );
  }
}
