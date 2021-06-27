import 'dart:async';
import 'package:biltek/Widgets/showDialog.dart';
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
      Get.to(() => AnaSayfa());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        showMaterialDialog(title: "Hatalı kullanıcı bilgileri ",
            content: "Lütfen bilgilerinizi kontrol ediniz",
            context: context);

      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showMaterialDialog(title: "Hatalı kullanıcı bilgileri ",
            content: "Lütfen bilgilerinizi kontrol ediniz",
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;

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
                                "assets/logo3.png",
                                width: width * 4 / 9,
                              )),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: height * 1 / 14,
                          width: width * 9.6 / 10,
                          decoration: BoxDecoration(
                            border: Border.all(color: turuncu, width: 2),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8,top: 8),
                            child: TextFormField(
                              cursorColor: turuncu,
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
                                  hintStyle:
                                  TextStyle(color: Colors.grey.shade700)
                                // icon is 48px widget.
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(

                          height: height * 1 / 14,
                          width: width * 9.6 / 10,
                          decoration: BoxDecoration(
                            border: Border.all(color: turuncu, width: 2),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8,top: 8),
                            child: TextFormField(

                                controller: t2,
                                style: TextStyle(color: Colors.grey.shade800),
                                obscureText: showPassword,
                                decoration: InputDecoration(
                                  fillColor: turuncu,
                                  hoverColor: turuncu,
                                  hintText: "Şifre",
                                  hintStyle:
                                  TextStyle(color: Colors.grey.shade700),
                                  suffixIcon: showPassword == false
                                      ? IconButton(
                                    icon: Icon(Icons.visibility_off),
                                    color: Colors.grey.shade700,
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
                                  ), // icon is 48px widget.
                                ),
                                validator: (deger) {
                                  if (deger!.isEmpty || deger.length < 6) {
                                    return "Lütfen 6 karakterden uzun bir şifre giriniz";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        SizedBox(height: 25,),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 1 / 30,

                            right: width * 1 / 30,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                girisYap();
                              }
                            },
                            child: Container(
                                child: Image.asset(
                                  "assets/grs1.png",
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 1 / 30,
                            right: width * 1 / 30,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => SignUp());
                            },
                            child: Container(
                                child: Image.asset(
                                  "assets/kyt1.png",
                                  fit: BoxFit.fill,
                                )),
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
