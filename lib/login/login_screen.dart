import 'package:chat_app/general_functions.dart' as GF;
import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/login/login_navigator.dart';
import 'package:chat_app/login/login_view_model.dart';
import 'package:chat_app/register/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  String email = '';

  String password = '';

  var formKey = GlobalKey<FormState>();

  LoginViewModel viewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            title: const Text('Log IN',
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
                                r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
                    const SizedBox(height: 24),
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
                          "Log IN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                        child: const Text("Don't have account yet"))
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> validateCheck() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.loginFirebase(email, password);
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
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeNaeme);
    }, 'OK');
  }
}
