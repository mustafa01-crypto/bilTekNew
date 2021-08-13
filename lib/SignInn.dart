import 'dart:async';
import 'package:biltek/Widgets/showDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SignUpp.dart';
import 'anaSayfa.dart';

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

        showMaterialDialog(
            title: "Hatalı kullanıcı bilgileri ",
            content: "Lütfen bilgilerinizi kontrol ediniz",
            context: context);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showMaterialDialog(
            title: "Hatalı kullanıcı bilgileri ",
            content: "Lütfen bilgilerinizi kontrol ediniz",
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
   // final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [

            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: 0.85,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.red,
                        Colors.blue,
                      ]),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'assets/logo2.png',
                    height: width * 1 / 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'BİLGİ VE TEKNOLOJİ',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        hintText: "Email Adresi",
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey.shade300,
                        ), // icon is 48px widget.
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Lütfen geçerli bir mail adresi giriniz";
                      },
                      controller: t1,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Parola",
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: "Parola",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey.shade300,
                        ),
                        suffixIcon: showPassword == false
                            ? IconButton(
                                icon: Icon(Icons.visibility_off),
                                color: Colors.grey.shade300,
                                onPressed: () {
                                  setState(() {
                                    showPassword = true;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.remove_red_eye_outlined),
                                color: Colors.grey.shade300,
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
                      },
                      controller: t2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          girisYap();

                          //Get.to(() => AnaSayfa());
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Center(
                          child: Text(
                            "GİRİŞ YAP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, -1), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabım yok",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => SignUp());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
