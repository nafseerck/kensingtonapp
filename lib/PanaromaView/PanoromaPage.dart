import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  String link;
  WebViewExample({
    Key key,this.link
  }) : super(key: key);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: ColorConstant.kWhiteColor,
        appBar:CustomWidget.getappbar1(context),
        body:  WebView(

          initialUrl: widget.link,
          javascriptMode: JavascriptMode.unrestricted,

        ),
      );

  }
}