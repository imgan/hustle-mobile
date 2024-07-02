import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView(
      {super.key,
      required this.title,
      required this.webViewController,
      this.onWillPop});

  final String title;
  final WebViewController webViewController;
  final Future<bool> Function()? onWillPop;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop ??
          () async {
            return true;
          },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          onPressed: onWillPop,
          title: title,
        ),
        body: WebViewWidget(
          controller: webViewController,
        ),
      ),
    );
  }
}
