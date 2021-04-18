import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/models/server_error.dart';
import 'package:testapp/core/services/preference/preference.dart';

class RequestType {
  static const String Get = 'get';
  static const String Post = 'post';
  static const String Put = 'put';
  static const String Delete = 'delete';
}

class Header {
  // static Map<String, dynamic> clientAuth({@required String clientID}) {
  //   final hashedClient = const Base64Encoder().convert("$clientID:".codeUnits);
  //   return {'Authorization': 'Basic $hashedClient'};
  // }

  static Map<String, dynamic> get clientAuth => {'Authorization': ''};

  // static Map<String, dynamic> get userAuth =>
  //     {'Authorization': 'Bearer ${Preference.getString(PrefKeys.fcmToken)}'};
}

class EndPoint {
  static const String TODO = 'todos';
  static const String REGISTER = 'register';
  static const String TOKEN = 'auth/token';
  static const String USER = 'user';
  static const String POST = 'posts';
  static const String COMMENT = 'comment';
  static const String REPLY = 'reply';
}

abstract class Api {
  Future<LoginResponse> login({String username, String password});

  Future<User> getUser(int userId);

  Future<List<Post>> getPostsForUser(int userId);

  Future<List<Comment>> getCommentsForPost(int postId);
}
