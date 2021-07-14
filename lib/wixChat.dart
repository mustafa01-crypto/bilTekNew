import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:webview_flutter/webview_flutter.dart';

late User loggedInuser;

class WixChat extends StatefulWidget {
  const WixChat({Key? key}) : super(key: key);

  @override
  _WixChatState createState() => _WixChatState();
}

class _WixChatState extends State<WixChat> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Tawk(
              directChatLink:
                  'https://tawk.to/chat/60ca68557f4b000ac038014e/1f8baf44h',
              visitor: TawkVisitor(
                name: loggedInuser.displayName,
                email: loggedInuser.email,
              )),
        ),
      ),
    );
  }
}
