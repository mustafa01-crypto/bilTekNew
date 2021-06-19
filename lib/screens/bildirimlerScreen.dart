import 'package:biltek/constants/constants.dart';
import 'package:biltek/screens/pastScreen.dart';
import 'package:biltek/screens/yazilimDestekScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Norifications extends StatefulWidget {
  const Norifications({Key? key}) : super(key: key);

  @override
  _NorificationsState createState() => _NorificationsState();
}

class _NorificationsState extends State<Norifications> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: turuncu,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 35,),
                onPressed: ()
                {
                  Get.back();
                },
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Servis Hizmetleri",
                  ),
                  Tab(text: "Yazılım Hizmetleri"),
                ],
              ),
              centerTitle: true,
              title: Text('HİZMETLERİMİZ'),
            ),
            body: TabBarView(
              children: [
                PastScreen(),
                YazilimDestek(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
