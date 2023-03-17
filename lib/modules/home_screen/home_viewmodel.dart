import 'package:chat_own/base_class.dart';
import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/shared/network/cloud_firestore_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<ChatRoomModel> chatlist = [];

  void readRooms() {
    CloudFirestoreUtils.readRoomsFromFirestore().asStream();

  }

  Stream<QuerySnapshot<ChatRoomModel>> readRoomsAsStream(){
   return CloudFirestoreUtils.readRoomsFromFirestoreAsStream();
}
}
