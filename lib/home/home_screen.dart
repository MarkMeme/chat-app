import 'package:chat_app/add_room/add_room.dart';
import 'package:chat_app/add_room/room_widget.dart';
import 'package:chat_app/database/database_usils.dart';
import 'package:chat_app/home/home_navigator.dart';
import 'package:chat_app/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/room.dart';

class HomeScreen extends StatefulWidget {
  static const String routeNaeme = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
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
              title: const Text('Home',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoom.routeName);
              },
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
            body: StreamBuilder<QuerySnapshot<Room>>(
              stream: DatabaseUsils.getRooms(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF2872A4),
                    ),
                  );
                } else if (asyncSnapshot.hasError) {
                  return Text(asyncSnapshot.error.toString());
                } else {
                  var roomsList = asyncSnapshot.data?.docs
                      .map((doc) => doc.data())
                      .toList();
                  return GridView.builder(
                    itemCount: roomsList?.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return RoomWidget(room: roomsList![index]);
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
