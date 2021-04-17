import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/services/api/api.dart';

class StaticContentPageModel extends BaseNotifier {
  final Api api;

  StaticContentPageModel({@required this.api}) {
    someFunction();
  }
  someFunction() async {
    await Future.delayed(Duration(seconds: 5));

    setState(state: NotifierState.idle);
  }

  renderAgain() {
    setState();
  }
}
