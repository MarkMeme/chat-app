import 'package:chat_app/add_room/add_room_navigator.dart';
import 'package:chat_app/add_room/add_room_view_model.dart';
import 'package:chat_app/model/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'add rome';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  var categoryList = Category.getCategory();
  String roomTitle = '';
  String roomDescription = '';
  var formKey = GlobalKey<FormState>();
  late Category selectedItem;

  AddRoomViewModel viewModel = AddRoomViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectedItem = categoryList[0];
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
              title: const Text('New Room',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              width: double.infinity,
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
              child: Form(
                //key: formKey.,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create New Room',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset('assets/images/group.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (title) {
                        roomTitle = title;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter Room Name',
                        helperStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Title';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton<Category>(
                        alignment: Alignment.center,
                        autofocus: true,
                        value: selectedItem,
                        style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        items: categoryList
                            .map((category) => DropdownMenuItem<Category>(
                                value: category,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(category.title),
                                    SizedBox(
                                      width: 33,
                                    ),
                                    Image.asset(category.image)
                                  ],
                                )))
                            .toList(),
                        onChanged: (newCategory) {
                          if (newCategory == null) return;
                          selectedItem = newCategory;
                          setState(() {});
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (description) {
                        roomDescription = description;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Description';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter Room Description',
                        helperStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      maxLines: 4,
                      minLines: 3,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
