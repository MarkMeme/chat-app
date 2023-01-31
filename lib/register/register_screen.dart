import 'package:chat_app/general_functions.dart' as GF;
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/register/register_navigator.dart';
import 'package:chat_app/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  String firstName = '';

  String lastName = '';

  String userName = '';

  String email = '';

  String password = '';

  var formKey = GlobalKey<FormState>();

  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
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
              title: const Text('Create Account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelText: 'First Name',
                          labelStyle: TextStyle(fontSize: 18),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (text) {
                          firstName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter First Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelText: 'Last Name',
                          labelStyle: TextStyle(fontSize: 18),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (text) {
                          lastName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Last Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelText: 'User Name',
                          labelStyle: TextStyle(fontSize: 18),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (text) {
                          userName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter User Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 18),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                              .hasMatch(text!);
                          if (!emailValid) {
                            return 'Enter Valid a Email';
                          }
                          if (text.trim().isEmpty) {
                            return 'Please Enter Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 18),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Password';
                          }
                          if (text.length < 8) {
                            return 'Password must be at least 8 chars.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF2872A4)),
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10))),
                          onPressed: () {
                            validateCheck();
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> validateCheck() async {
    if (formKey.currentState?.validate() == true) {
      //register
      viewModel.registering(email, password);
    }
  }

  @override
  void hideLoading() {
    GF.hideLoading(context);
  }

  @override
  void showLoading() {
    GF.showLoading(context, 'Loading...');
  }

  @override
  void showMessage(String message) {
    GF.showMessage(context, message, (context) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }, 'OK');
  }
}
