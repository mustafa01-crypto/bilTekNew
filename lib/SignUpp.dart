import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'SignInn.dart';
import 'anaSayfa.dart';
import 'constants/constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();
  TextEditingController t7 = TextEditingController();
  TextEditingController t11 = TextEditingController();
  TextEditingController t12 = TextEditingController();
  TextEditingController t13 = TextEditingController();
  TextEditingController t14 = TextEditingController();
  TextEditingController t15 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  TextStyle hint = TextStyle(
    color: Colors.white,
  );

  static Future<bool> signUp(name, email, password, tc, tel, adresadi, adres1,
      adres2, ilce, postaKodu) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? signedInUser = authResult.user;

      if (signedInUser != null) {
        _firestore.collection('users').doc(signedInUser.email).set({
          'name': name,
          'email': email,
          'parola': password,
          'tc': tc,
          'tel': tel,
          "adresadi": adresadi,
          "adres1": adres1,
          "adres2": adres2,
          "ilce/semt": ilce,
          "postakodu": postaKodu,
        });

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
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
                    margin:
                        EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 50),
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 1 / 20),
                          child: Image.asset(
                            "assets/logo2.png",
                            width: width * 4 / 9,
                          ),
                        ),
                        SizedBox(height: 25,),
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
                          child: formElement(
                              textEditingController: t1,
                              text: "Ad Soyad",
                              textInputType: TextInputType.text,
                              icon: Icon(
                                Icons.warning,
                                size: 25,
                                color: turuncu,
                              )),
                        ),
                        SizedBox(height: 15,),
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
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.grey.shade800),
                              controller: t2,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                suffixIcon: Icon(
                                  Icons.warning,
                                  size: 25,
                                  color: turuncu,
                                ),

                                // icon is 48px widget.
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
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
                              validator: (deger) {
                                if (deger!.isEmpty || deger.length < 6) {
                                  return "Lütfen 6 karakterden uzun bir şifre giriniz";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.grey.shade800),
                              controller: t3,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Parola",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                suffixIcon: Icon(
                                  Icons.warning,
                                  size: 25,
                                  color: turuncu,
                                ),


                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
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
                              validator: (deger) {
                                if (t3.text == t4.text) {
                                  if (deger!.isEmpty || deger.length < 6) {
                                    return "Lütfen 6 karakterden uzun bir şifre giriniz";
                                  }
                                  return null;
                                }
                                return "Parola aynı olmalıdır";
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.grey.shade800),
                              controller: t4,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Parola Yeniden",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                suffixIcon: Icon(
                                  Icons.warning,
                                  size: 25,
                                  color: turuncu,
                                ),

                                // icon is 48px widget.
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
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
                          child: formElement(
                              textEditingController: t5,
                              text: "TC Kimlik Numarası",
                              textInputType: TextInputType.number),
                        ),
                        SizedBox(height: 15,),
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
                          child: formElement(
                              textEditingController: t6,
                              text: "Telefon Numarası",
                              textInputType: TextInputType.number),
                        ),
                        SizedBox(
                          height: height * 1 / 20,
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
                          child: formElement(
                              textEditingController: t11,
                              text: "Adres Adı",
                              icon: Icon(
                                Icons.warning,
                                size: 25,
                                color: turuncu,
                              )),
                        ),
                        SizedBox(height: 15,),
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
                          child: formElement(
                              textEditingController: t12,
                              text: "Adres 1",
                              icon: Icon(
                                Icons.warning,
                                size: 25,
                                color: turuncu,
                              )),
                        ),
                        SizedBox(height: 15,),
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
                          child: formElement(
                              textEditingController: t13, text: "Adres 2"),
                        ),
                        SizedBox(height: 15,),
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
                          child: formElement(
                              textEditingController: t14,
                              text: "İlçe/Semt",
                              icon: Icon(
                                Icons.warning,
                                size: 25,
                                color: turuncu,
                              )),
                        ),
                        SizedBox(height: 15,),
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
                          child: formElement(
                              textEditingController: t15,
                              text: "Posto Kodu",
                              textInputType: TextInputType.number),
                        ),
                        SizedBox(
                          height: height * 1 / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                Get.to(() => SignIn());
                              },
                              child: Image.asset(
                                "assets/var.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                signUp(
                                    t1.text,
                                    t2.text,
                                    t3.text,
                                    t5.text,
                                    t6.text,
                                    t11.text,
                                    t12.text,
                                    t13.text,
                                    t14.text,
                                    t15.text);

                                Get.to(() => AnaSayfa());
                              }
                            },
                            child: Container(
                                child: Image.asset(
                              "assets/devam.png",
                              fit: BoxFit.fill,
                            )),
                          ),
                        ),
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

  Widget formElement(
      {@required TextEditingController? textEditingController,
      String? text,
      TextInputType? textInputType,
      Icon? icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 8,top: 8),
      child: TextFormField(
        cursorColor: turuncu,
        keyboardType: textInputType,
        style: TextStyle(color: Colors.grey.shade800),
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: icon, hintText: text,
          hintStyle: TextStyle(color: Colors.grey.shade700),
          // icon is 48px widget.
        ),
      ),
    );
  }
}
