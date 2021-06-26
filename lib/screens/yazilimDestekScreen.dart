import 'package:biltek/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


late User loggedInuser;

class YazilimDestek extends StatefulWidget {
  const YazilimDestek({Key? key}) : super(key: key);

  @override
  _YazilimDestekState createState() => _YazilimDestekState();
}

class _YazilimDestekState extends State<YazilimDestek> {
  FirebaseAuth auth = FirebaseAuth.instance;

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

    Query yazilimDestek = FirebaseFirestore.instance
        .collection('yazilimDestek')
        .where("id", isEqualTo: auth.currentUser!.uid);

    return StreamBuilder<QuerySnapshot>(
      stream: yazilimDestek.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot1.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder<QuerySnapshot>(
          stream: yazilimDestek.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return new ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 1 / 40,vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 1 / 10,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: turuncu),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                kisaExpanded(document, 'talepturu'),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Color(0xFFF6F4F4),
                                ),
                                kisaExpanded(document, 'talep'),

                              ],

                            ),
                          ),

                        ),

                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  Widget kisaExpanded(dynamic document, String doc) {
    return Expanded(
        child: Center(
      child:
          new Text(document.data()[doc],textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 14)),
    ));
  }
}
