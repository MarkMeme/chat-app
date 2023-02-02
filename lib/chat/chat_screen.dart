import 'package:chat_app/chat/chat_screen_navigator.dart';
import 'package:chat_app/chat/chat_screen_view_model.dart';
import 'package:chat_app/chat/message_widget.dart';
import 'package:chat_app/general_functions.dart' as GF;
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/room.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat screen';
  TextEditingController controller = TextEditingController();

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatViewModel viewModel = ChatViewModel();
  var messageContent = '';

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = provider.user!;
    viewModel.monitorMessages();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/SIGN IN – 1.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(args.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //width: double.infinity,
                //height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 8,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: StreamBuilder(
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF2872A4),
                            ),
                          );
                        } else if (asyncSnapshot.hasError) {
                          return Text(asyncSnapshot.error.toString());
                        } else {
                          var messagesList = asyncSnapshot.data?.docs
                                  .map((e) => e.data())
                                  .toList() ??
                              [];
                          return ListView.builder(
                            reverse: true,
                            itemBuilder: (context, index) {
                              return MessageWidget(
                                  message: messagesList[index]);
                            },
                            itemCount: messagesList.length,
                          );
                        }
                      },
                      stream: viewModel.streamMessage,
                    )),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: widget.controller,
                          onChanged: (text) {
                            messageContent = text;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: 'Type a message',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF2872A4), width: 1.5),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF2872A4), width: 3),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5)),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 7,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color(0xFF2872A4)),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 11.5))),
                            onPressed: () {
                              clearMessage();
                              if (messageContent != '') {
                                viewModel.sendMessage(messageContent);
                              }
                              messageContent = '';
                            },
                            child: Row(
                              children: const [
                                Text('Send'),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.send_outlined,
                                  size: 25,
                                )
                              ],
                            ))
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  void showMessage(String message) {
    GF.showMessage(context, message, () {
      Navigator.pop(context);
    }, 'OK');
  }

  @override
  void clearMessage() {
    widget.controller.clear();
  }
}

/*

 */
