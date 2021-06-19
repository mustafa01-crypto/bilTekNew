import 'dart:io';
import 'dart:ui';
import 'package:biltek/Widgets/showDialog.dart';
import 'package:biltek/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../SignInn.dart';
import 'bildirimlerScreen.dart';

late User loggedInuser;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  File? yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? indirmeBaglantisi;
  String? name;
  String? email;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  void initState() {
    super.initState();
    getCurrentUser();
    baglantiAl();
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

  baglantiAl() async {
    String baglanti = await FirebaseStorage.instance
        .ref()
        .child("profilresimleri")
        .child(loggedInuser.email!)
        .child("profilResmi.png")
        .getDownloadURL();

    setState(() {
      indirmeBaglantisi = baglanti;
    });
  }

  kameradanYukle() async {
    var alinanDosya = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      yuklenecekDosya = File(alinanDosya!.path);
    });

    Reference referansYol = FirebaseStorage.instance
        .ref()
        .child("profilresimleri")
        .child(loggedInuser.email!)
        .child("profilResmi.png");

    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya!);
    String url = await (await yuklemeGorevi.whenComplete(() => null))
        .ref
        .getDownloadURL();
    setState(() {
      indirmeBaglantisi = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    TextStyle inputStyle =
        TextStyle(color: Colors.grey.shade900, fontSize: width * 1 / 24);
    TextStyle buttonText = TextStyle(
        fontSize: width * 1 / 20,
        color: Colors.white,
        fontWeight: FontWeight.bold);
    return Scaffold(
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
            onPressed: () {
              Get.to(Norifications());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      size: width * 1 / 10,
                      color: turuncu,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((deger) {
                        Get.to(() => SignIn());
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: width * 3 / 10,
                    right: width * 3 / 10,
                    bottom: height * 1 / 50),
                child: Center(
                    child: InkWell(
                      onTap: () {
                        kameradanYukle();
                      },
                      child: ClipOval(
                          child: indirmeBaglantisi == null
                              ? Image.asset(
                            "assets/prof.png",
                            width: 100,
                            height: 100,
                          )
                              : Image.network(
                            indirmeBaglantisi!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )),
                    ))),
            Text(
              "Text 1",
              style: TextStyle(
                  color: Colors.grey.shade900, fontSize: width * 1 / 22),
            ),
            SizedBox(
              height: height * 1 / 120,
            ),
            Text("Text 2",
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: width * 1 / 25)),
            SizedBox(
              height: height * 1 / 60,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 1 / 20, right: width * 1 / 20),
              child: Container(
                height: height * 1 / 20,
                width: width * 9 / 10,
                decoration: BoxDecoration(
                  border: Border.all(color: turuncu, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Text 3",
                      hintStyle: inputStyle,
                      labelStyle:
                      new TextStyle(color: const Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 1 / 60,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 1 / 20, right: width * 1 / 20),
              child: Container(
                height: height * 1 / 20,
                width: width * 9 / 10,
                decoration: BoxDecoration(
                  border: Border.all(color: turuncu, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "hahah",
                      hintStyle: inputStyle,
                      labelStyle:
                      new TextStyle(color: const Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 1 / 60,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 1 / 19),
              child: Row(
                children: [
                  Text(
                    "Bildirimlerden haberder olmak istiyorum",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeTrackColor: Colors.orangeAccent,
                    activeColor: turuncu,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 1 / 20, right: width * 1 / 20),
              child: Container(
                width: width * 9 / 10,
                height: height * 1 / 15,
                child: ElevatedButton(
                  onPressed: () {
                    showMaterialDialog(
                      context: context,
                      title: "Bilgileriniz Güncellendi",
                      content: "Bilgileriniz Güncellendi",
                    );
                  },
                  child: Text(
                    'Bilgileri Güncelle',
                    style: buttonText,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: turuncu,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 1 / 60,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 1 / 20, right: width * 1 / 20),
              child: Container(
                width: width * 9 / 10,
                height: height * 1 / 15,
                child: ElevatedButton(
                  onPressed: () {
                    //  baglantiAl();
                  },
                  child: Text(
                    'Bilgileri Güncelle',
                    style: buttonText,
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
      ),
    );
  }
}
