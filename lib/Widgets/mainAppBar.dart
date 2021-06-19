import 'package:flutter/material.dart';


Widget maniAppBar(BuildContext context, List<Widget> actions,TextEditingController controller) {

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;

  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;

  return AppBar(
    backgroundColor: Colors.white,
    title:   Center(
        child: _isSearching == false ? Image(
          image:  ExactAssetImage("assets/appBar.png"),
          height: height*1/14,
          width: width *1/2,
          alignment: Alignment.center,
        ) : TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Arama yapın",
          ),
        )
    ),

    actions: actions,

  );
}