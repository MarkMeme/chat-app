import 'package:chat_app/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/room.dart';

class DatabaseUsils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionNanme)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, options) => user.toJson());
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (snapshot, options) =>
                Room.fromJson(snapshot.data()!),
            toFirestore: (room, options) => room.toJson());
  }

  static Future<void> registerUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUser(String userId) async {
    var documentSnapshot = await getUserCollection().doc(userId).get();
    return documentSnapshot.data();
  }

  static Future<void> addRoomToFirestore(Room room) {
    var docRef = getRoomCollection().doc();
    room.roomId = docRef.id;
    return docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRooms() {
    return getRoomCollection().snapshots();
  }
}
