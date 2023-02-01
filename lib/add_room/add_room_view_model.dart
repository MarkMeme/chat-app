import 'package:chat_app/add_room/add_room_navigator.dart';
import 'package:chat_app/database/database_usils.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;

  addRoom(String title, String description, String categoryId) {
    Room room = Room(
        title: title,
        categoryId: categoryId,
        description: description,
        roomId: '');
    try {
      navigator.showLoading();
      var createdRoom = DatabaseUsils.addRoomToFirestore(room);
      navigator.hideLoading();
      navigator.showMessage('Room has added successfully');
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}
