import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SignUpp.dart';
import 'anaSayfa.dart';
import 'constants/constants.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  bool showPassword = true;
  late StreamSubscription<User?> _listener;

  static final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();

    _listener = _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Get.to(() => AnaSayfa());
      }
    });
  }

  Future<void> girisYap() async {
    try {
      await _auth.signInWithEmailAndPassword(email: t1.text, password: t2.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0, bottom: 50),
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 1 / 10),
                          child: Center(
                              child: Image.asset(
                            "assets/logo2.png",
                            width: width * 1 / 3,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 15, right: 8, bottom: 15),
                          child: TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Lütfen geçerli bir mail adresi giriniz";
                            },
                            controller: t1,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.grey.shade800),
                            decoration: InputDecoration(
                                hintText: "E mail",
                                hintStyle: TextStyle(color: Colors.grey.shade700)
                                // icon is 48px widget.
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 15, right: 8, bottom: 15),
                          child: TextFormField(
                              controller: t2,
                              style: TextStyle(color: Colors.grey.shade800),
                              obscureText: showPassword,
                              decoration: InputDecoration(
                                hintText: "Şifre",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: showPassword == false
                                      ? IconButton(
                                          icon: Icon(Icons.remove_red_eye),
                                          color:
                                              Colors.lightBlueAccent.shade700,
                                          onPressed: () {
                                            setState(() {
                                              showPassword = true;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.remove_red_eye),
                                          color: Colors.grey.shade700,
                                          onPressed: () {
                                            setState(() {
                                              showPassword = false;
                                            });
                                          },
                                        ),
                                ), // icon is 48px widget.
                              ),
                              validator: (deger) {
                                if (deger!.isEmpty || deger.length < 6) {
                                  return "Lütfen 6 karakterden uzun bir şifre giriniz";
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 1 / 30,
                              top: 15,
                              right: width * 1 / 30,
                              bottom: 15),
                          child: InkWell(
                            onTap: (){
                              if (_formKey.currentState!.validate()) {
                                girisYap();

                                Get.to(() => AnaSayfa());
                              }
                            },
                            child: Container(

                              child: Image.asset("assets/grs1.png",fit: BoxFit.fill,)
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 1 / 30,
                              top: 15,
                              right: width * 1 / 30,
                              bottom: 15),
                          child: InkWell(
                            onTap: ()
                            {
                              Get.to(() => SignUp());
                            },
                            child: Container(

                              child: Image.asset("assets/kyt1.png",fit: BoxFit.fill,)
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
