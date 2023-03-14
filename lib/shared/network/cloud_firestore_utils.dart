import 'package:chat_own/models/chat_room.dart';
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

  static Future<void> addUserToDatabase(UserModel user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<void> addRoomToDatabase(ChatRoomModel chatRoom) {
    CollectionReference roomsCollection = getRoomsCollection();
    DocumentReference docRef = roomsCollection.doc();
    chatRoom.id=docRef.id;
    return docRef.set(chatRoom);
  }

  static Future<UserModel?> readUserFromDatabase(String? id) async {
    var userSnapshot = await getUsersCollection().doc(id).get();
    UserModel? user = userSnapshot.data();
    return user;
  }
}
