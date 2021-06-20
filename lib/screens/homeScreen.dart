import 'package:biltek/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';

import 'bildirimlerScreen.dart';

late User loggedInuser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
              Get.to(Norifications());
            },
          ),

        ],

      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(

        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: turuncu,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kart Numarası',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tarih',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kart Sahibi',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                      child: Image.asset("assets/stnal.png",fit: BoxFit.fill,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
