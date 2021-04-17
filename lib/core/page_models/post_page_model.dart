import 'dart:math';

import 'package:base_notifier/base_notifier.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/models/post_model.dart';
import 'package:testapp/core/models/server_error.dart';
import 'package:testapp/core/services/api/http_api.dart';
import 'package:testapp/core/services/auth/authentication_service.dart';
import 'package:ui_utils/ui_utils.dart';

class PostsPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  PostsPageModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    getPosts();
  }

  List<PostModel> posts;

  getPosts() async {
    setBusy();
    Either<ServerError, dynamic> res = await api.getUserPosts();

    res.fold((error) {
      UI.toast(error.toString());
      setError();
    }, (data) {
      print(data);
      posts = data.map<PostModel>((item) => PostModel.fromJson(item)).toList();
      setIdle();
    });
  }

  getError401() async {
    setBusy();
    Either<ServerError, dynamic> res = await api.getError401();

    res.fold((error) {
      setError();
      UI.dialog(
          context: context,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error.toString()),
          )));
    }, (_) {});
  }

  getError404() async {
    setBusy();
    Either<ServerError, dynamic> res = await api.getError404();

    res.fold((error) {
      setError();
      UI.dialog(
          context: context,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error.toString()),
          )));
    }, (_) {
      setIdle();
    });
  }
}
