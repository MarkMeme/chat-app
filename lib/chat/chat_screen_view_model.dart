import 'package:chat_app/chat/chat_screen_navigator.dart';
import 'package:chat_app/database/database_usils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/room.dart';

class ChatViewModel extends ChangeNotifier {
  late ChatNavigator navigator;
  late MyUser currentUser;

  late Room room;
  late Stream<QuerySnapshot<Message>> streamMessage;

  Future<void> sendMessage(String content) async {
    Message message = Message(
        roomId: room.roomId,
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        senderId: currentUser.id,
        senderName: currentUser.userName);
    try {
      var result = await DatabaseUsils.insertMessage(message);
      navigator.clearMessage();
    } catch (error) {
      return navigator.showMessage(error.toString());
    }
  }

  monitorMessages() {
    streamMessage = DatabaseUsils.getMessageFromFirebase(room.roomId);
  }
}
