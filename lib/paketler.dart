import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Paketler extends StatefulWidget {
  const Paketler({Key? key}) : super(key: key);

  @override
  _PaketlerState createState() => _PaketlerState();
}

class _PaketlerState extends State<Paketler> {

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: 'https://hasansabbah284.wixsite.com/pazarlama',
        javascriptMode: JavascriptMode.unrestricted,

      ),
    );
  }
}
