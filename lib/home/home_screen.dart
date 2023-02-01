import 'package:chat_app/add_room/add_room.dart';
import 'package:chat_app/home/home_navigator.dart';
import 'package:chat_app/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          )
        ],
      ),
    );
  }
}
