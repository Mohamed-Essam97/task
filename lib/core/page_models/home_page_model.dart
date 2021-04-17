import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:testapp/ui/routes/route.dart';
import 'package:ui_utils/ui_utils.dart';

import '../models/api_models.dart';

class HomePageModel extends BaseNotifier {
  final Api api;

  HomePageModel({@required this.api}) {
    someFunction();
  }
  someFunction() async {
    await Future.delayed(Duration(seconds: 5));

    Logger().v("Verbose log ");

    Logger().d("Debug log");

    Logger().i("Info log");

    Logger().w("Warning log");

    Logger().e("Error log");

    Logger().wtf("What a terrible failure log");

    setState(state: NotifierState.idle);
  }

  openPostPage(BuildContext context) async {
    UI.push(context, Routes.post(Post()));
  }

  renderAgain() {
    setState();
  }
}
