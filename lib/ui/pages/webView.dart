import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  String webUrl;
  WebViewPage({this.webUrl});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return BaseWidget<WebViewPageModel>(
        initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) {}),
        model: WebViewPageModel(context: context),
        builder: (context, model, _child) => Scaffold(
              body: WebviewScaffold(
                url: "$webUrl",
                appBar: new AppBar(
                  title: new Text(webUrl),
                  backgroundColor: Colors.blue[800],
                ),
              ),
            ));
  }
}

class WebViewPageModel extends BaseNotifier {
  final BuildContext context;

  WebViewPageModel({
    NotifierState state,
    this.context,
  }) : super(state: state);
}
