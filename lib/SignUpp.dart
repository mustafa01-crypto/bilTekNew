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
        backgroundColor: mavi,
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
                      color: mavi,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 1 / 20),
                          child: Image.asset(
                            "assets/logo2.png",
                            width: width * 1 / 3,
                          ),
                        ),
                        formElement(
                            textEditingController: t1,
                            text: "Ad Soyad",
                            textInputType: TextInputType.text,
                            icon: Icon(
                              Icons.ac_unit,
                              size: 30,
                              color: turuncu,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 5, right: 8, bottom: 5),
                          child: TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Lütfen geçerli bir mail adresi giriniz";
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            controller: t2,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: hint,
                              suffixIcon: Icon(
                                Icons.ac_unit,
                                size: 30,
                                color: turuncu,
                              ),

                              // icon is 48px widget.
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 5, right: 8, bottom: 5),
                          child: TextFormField(
                            validator: (deger) {
                              if (deger!.isEmpty || deger.length < 6) {
                                return "Lütfen 6 karakterden uzun bir şifre giriniz";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),
                            controller: t3,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Parola",
                              hintStyle: hint,
                              suffixIcon: Icon(
                                Icons.ac_unit,
                                size: 30,
                                color: turuncu,
                              ),

                              // icon is 48px widget.
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 5, right: 8, bottom: 5),
                          child: TextFormField(
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
                            style: TextStyle(color: Colors.white),
                            controller: t4,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Parola Yeniden",
                              hintStyle: hint,
                              suffixIcon: Icon(
                                Icons.ac_unit,
                                size: 30,
                                color: turuncu,
                              ),

                              // icon is 48px widget.
                            ),
                          ),
                        ),
                        formElement(
                            textEditingController: t5,
                            text: "TC Kimlik Numarası",
                            textInputType: TextInputType.number),
                        formElement(
                            textEditingController: t6,
                            text: "Telefon Numarası",
                            textInputType: TextInputType.number),
                        SizedBox(
                          height: height * 1 / 20,
                        ),
                        formElement(
                            textEditingController: t11,
                            text: "Adres Adı",
                            icon: Icon(
                              Icons.ac_unit,
                              size: 30,
                              color: turuncu,
                            )),
                        formElement(
                            textEditingController: t12,
                            text: "Adres 1",
                            icon: Icon(
                              Icons.ac_unit,
                              size: 30,
                              color: turuncu,
                            )),
                        formElement(
                            textEditingController: t13, text: "Adres 2"),
                        formElement(
                            textEditingController: t14,
                            text: "İlçe/Semt",
                            icon: Icon(
                              Icons.ac_unit,
                              size: 30,
                              color: turuncu,
                            )),
                        formElement(
                            textEditingController: t15,
                            text: "Posto Kodu",
                            textInputType: TextInputType.number),
                        SizedBox(
                          height: height * 1 / 30,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => SignIn());
                          },
                          child: Text(
                            "Hesabım var(Giriş Yap)",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * 1 / 2,
                            height: height * 1 / 15,
                            child: ElevatedButton(
                              onPressed: () {
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
                              child: Text(
                                'DEVAM ET',
                                style: TextStyle(fontSize: 22),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: turuncu,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
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
      padding: const EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
      child: TextFormField(
        keyboardType: textInputType,
        style: TextStyle(color: Colors.white),
        controller: textEditingController,
        decoration:
            InputDecoration(suffixIcon: icon, hintText: text, hintStyle: hint
                // icon is 48px widget.
                ),
      ),
    );
  }
}
