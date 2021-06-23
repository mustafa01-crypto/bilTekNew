import 'package:biltek/constants/constants.dart';
import 'package:biltek/paketler.dart';
import 'package:biltek/servis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bizeUlasin.dart';
import '../yazilim.dart';
import 'bildirimlerScreen.dart';

late User loggedInuser;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 30),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => Servis());
                        },
                        child: conPngler(resimYolu: "assets/servisss.png")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 48),
                    child: conPngler(resimYolu: "assets/booknote.png"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 30),
                    child: conPngler(resimYolu: "assets/tablets.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 48),
                    child: conPngler(resimYolu: "assets/internets.png"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 30),
                    child: InkWell(
                      onTap: ()
                        {
                          Get.to(Paketler());
                        },
                        child
                        : conPngler(resimYolu: "assets/pakets.png")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 48),
                    child: conPngler(resimYolu: "assets/yazicis.png"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 30),
                    child: conPngler(resimYolu: "assets/santrals.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 48),
                    child: conPngler(resimYolu: "assets/kameras.png"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 30),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => BizeUlasin());
                        },
                        child: conPngler(resimYolu: "assets/iletisims.png")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 48),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => Yazilim());
                        },
                        child: conPngler(resimYolu: "assets/yazilims.png")),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 30),
                    child: conPngler(resimYolu: "assets/yedeks.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 1 / 48),
                    child: conPngler(resimYolu: "assets/markets.png"),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget conPngler({required String resimYolu}) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 11 / 24,
      height: height * 1 / 7,
      child: Image.asset(
        resimYolu,
        fit: BoxFit.contain,
      ),
    );
  }
}
