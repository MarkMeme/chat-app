import 'package:chat_app/database/database_usils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == message.senderId
        ? SendMessage(
      message: message,
    )
        : RecieveMessage(
      message: message,
    );
  }
}

class SendMessage extends StatefulWidget {
  Message message;

  SendMessage({required this.message});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    int value = widget.message.dateTime.toInt();
    final f = DateFormat('yyyy-MM-dd hh:mm');
    var time = f.format(DateTime.fromMicrosecondsSinceEpoch(value * 1000));
    return GestureDetector(
      onDoubleTap: () {
        print("double tap");
        _modalBottomSheetMenu(context);
        //DatabaseUsils.deleteMessageFromFirebase(widget.message.roomId,widget.message.messageId);
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 250,
        margin: const EdgeInsets.fromLTRB(90, 10, 10, 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: const BoxDecoration(
            color: Color(0xff3598DB),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(0),
                topRight: Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.message.content,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  time,
                  //(@v / 10000, @v / 100 % 100, @v % 100);
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Icon(
                  Icons.keyboard_double_arrow_left,
                  size: 12,
                  color: Colors.white,
                ),
                //    const Icon(Icons.check,size: 12,),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        builder: (builder) {
          return Container(
            height: 250ch.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you want to delete this message ?',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.deepOrangeAccent),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10))),
                        onPressed: () {
                          DatabaseUsils.deleteMessageFromFirebase(
                              widget.message.roomId, widget.message.messageId);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ))
                  ],
                )),
          );
        },
        context: context);
  }
}

class RecieveMessage extends StatelessWidget {
  Message message;

  RecieveMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    int value = message.dateTime.toInt();
    final f = DateFormat('yyyy-MM-dd hh:mm');
    var time = f.format(DateTime.fromMicrosecondsSinceEpoch(value * 1000));
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 90, 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: const BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.keyboard_double_arrow_right,
                size: 12,
                color: Colors.white,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                time,
                //(@v / 10000, @v / 100 % 100, @v % 100);
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
// gestureDetector >>> on double tab
