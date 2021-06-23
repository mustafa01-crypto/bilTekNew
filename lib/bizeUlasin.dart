
import 'package:flutter/material.dart';
import 'constants/constants.dart';
class BizeUlasin extends StatefulWidget {
  const BizeUlasin({Key? key}) : super(key: key);

  @override
  _BizeUlasinState createState() => _BizeUlasinState();
}

class _BizeUlasinState extends State<BizeUlasin> {

  TextStyle firstStyle = TextStyle(fontSize: 23,color: turuncu,fontWeight: FontWeight.bold);
  TextStyle seconsStyle = TextStyle(fontSize: 20,color: turuncu);
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:   Center(
              child: _isSearching == false ? Image(
                image:  ExactAssetImage("assets/appBar.png"),
                height: height*1/14,
                width: width *1/2,
                alignment: Alignment.center,
              ) : TextField(
                controller: _searchQueryController,
                decoration: InputDecoration(
                  hintText: "Arama yapın",
                ),
              )
          ),


          actions: [
            _isSearching == false ? IconButton(
              icon: Icon(
                Icons.search,
                color: turuncu,
              ),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ):
            IconButton(
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

              },
            ),
          ],

        ),
        body: Padding(
          padding:  EdgeInsets.only(left: width*1/20,top: height*1/20,right: width*1/20),
          child: Container(
          margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10),
          height: height*3/12,
          width: width*9/10,
          decoration: BoxDecoration(
            border: Border.all(color: turuncu,width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),


          ),
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: width*1/15,top: height*1/25),
                  child: Row(

                    children: [
                      Text("GSM: ",style: firstStyle,),
                      Text("0532 436 85 28",style: seconsStyle,),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width*1/15,top: 5),
                  child: Row(

                    children: [
                      Text("Telefon: ",style: firstStyle,),
                      Text("0859 433 27 27",style: seconsStyle,),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: width*1/15,top: 5),
                  child: Row(
                    children: [
                      Text("Faks: ",style: firstStyle,),
                      Text("0312 483 00 90",style: seconsStyle,),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: width*1/15,top: 5),
                  child: Row(
                    children: [
                      Text("Mail: ",style: firstStyle,),
                      Text("info@teknolojihizmeti.com",style: seconsStyle,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



