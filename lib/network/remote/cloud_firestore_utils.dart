import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/models/message.dart';
import 'package:chat_own/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreUtils {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<ChatRoomModel> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(ChatRoomModel.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              ChatRoomModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<MessageModel> getMessagesCollection(
      String roomId) {
    return FirebaseFirestore.instance
        .collection("Rooms")
        .doc(roomId)
        .collection(MessageModel.collectionName)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<List<ChatRoomModel>> readRoomsFromFirestore() async {
    var snapshot = await getRoomsCollection().get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Stream<QuerySnapshot<ChatRoomModel>> readRoomsFromFirestoreAsStream() {
    return getRoomsCollection().snapshots();
  }

  static Future<List<MessageModel>> readMessagesFromFirestore(String roomId) async {
    var snapshots = await getMessagesCollection(roomId).get();
    return snapshots.docs.map((snapshot) => snapshot.data()).toList();
  }

  static Stream<QuerySnapshot<MessageModel>> readMessagesFromFirestoreAsStream(String roomId){
    return getMessagesCollection(roomId).orderBy("dateTime",).snapshots();
  }

  static Future<UserModel?> readUserFromDatabase(String? id) async {
    var userSnapshot = await getUsersCollection().doc(id).get();
    UserModel? user = userSnapshot.data();
    return user;
  }

  static Future<void> addUserToDatabase(UserModel user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<void> addRoomToDatabase(ChatRoomModel chatRoom) {
    CollectionReference roomsCollection = getRoomsCollection();
    DocumentReference docRef = roomsCollection.doc();
    chatRoom.id = docRef.id;
    return docRef.set(chatRoom);
  }

  static Future<void> addMessageToDatabase(MessageModel message) async {
    var messagesCollection = getMessagesCollection(message.roomId);
    message.id = messagesCollection.doc().id;
    return messagesCollection.doc(message.id).set(message);
  }
}
