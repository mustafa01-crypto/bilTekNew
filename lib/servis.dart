import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Widgets/showDialog.dart';
import 'constants/constants.dart';

late User loggedInuser;

class Servis extends StatefulWidget {
  const Servis({Key? key}) : super(key: key);

  @override
  _ServisState createState() => _ServisState();
}

class _ServisState extends State<Servis> {
  TextEditingController _searchQueryController = TextEditingController();
  TextEditingController t1 = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  String value = "Uzak Bağlantı Talebi";

  FirebaseAuth auth = FirebaseAuth.instance;

  TextStyle firstStyle = TextStyle(
      fontSize: 21,
      color: turuncu,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        loggedInuser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  talepGonder(talep) async {
    Random random = Random();
    String r = random.nextInt(99999).toString();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    if (loggedInuser != null) {
      _firestore.collection("servisDestek").doc(loggedInuser.email! + r).set({
        "id": auth.currentUser!.uid,
        "talepturu": value.toString(),
        "talep": talep,
        "isFixed": "0",
      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: _isSearching == false
                  ? Image(
                      image: ExactAssetImage("assets/appBar.png"),
                      height: height * 1 / 14,
                      width: width * 1 / 2,
                      alignment: Alignment.center,
                    )
                  : TextField(
                      controller: _searchQueryController,
                      decoration: InputDecoration(
                        hintText: "Arama yapın",
                      ),
                    )),
          actions: [
            _isSearching == false
                ? IconButton(
                    icon: Icon(
                      Icons.search,
                      color: turuncu,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: turuncu,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                      });
                    },
                  ),
            IconButton(
              icon: Icon(
                Icons.add_alert_sharp,
                color: turuncu,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 8,
                  right: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      "Servis Anlaşması >",
                      style: firstStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  children: [
                    Radio(
                        value: "Uzak Bağlantı Talebi",
                        groupValue: value,
                        onChanged: (String? deger) => {
                              setState(() {
                                value = deger!;
                              })
                            }),
                    Text(
                      " Uzak Bağlantı Talebi Oluşturun",
                      style: firstStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  children: [
                    Radio(
                        value: "Destek Talebi",
                        groupValue: value,
                        onChanged: (String? deger) {
                          setState(() {
                            value = deger!;
                          });
                        }),
                    Text(
                      " Destek Talebi Oluşturun",
                      style: firstStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Verilen Hizmetler",
                      style: firstStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 1 / 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: width * 1 / 20, right: width * 1 / 20),
                child: Container(
                  height: height * 3 / 10,
                  width: width * 9 / 10,
                  decoration: BoxDecoration(
                    border: Border.all(color: turuncu, width: 3),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextField(
                      controller: t1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Talebinizi Yazın",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        labelStyle:
                            new TextStyle(color: const Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 15, right: 8, bottom: 15),
                  child: InkWell(
                    onTap: ()
                    {
                      talepGonder(t1.text);
                      showMaterialDialog(
                          title: "Talebiniz Başarıyla Gönderildi",
                          content: "Talebiniz Başarıyla Gönderildi",
                          context: context);
                    },
                    child: Container(

                      child: Image.asset("assets/talep.png",fit: BoxFit.fill,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
