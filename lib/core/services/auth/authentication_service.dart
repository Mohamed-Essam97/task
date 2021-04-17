import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/services/api/api.dart';
import 'package:ui_utils/ui_utils.dart';

import '../../../ui/routes/route.dart';
import '../preference/preference.dart';

class AuthenticationService {
  final Api api;

  User _user;
  User get user => _user;

  AuthenticationService({this.api}) {
    // loadUser;
  }

  /*
  * Sign up user 
  */
  Future<void> signUp({String fullName, String email, String password}) async {
    try {
      _user = null; //🦄TODO:signUp implementation
      if (_user != null) {
        // Logger().i(_user.toJson());
        // saveUser(user: _user);
        // saveUserToken(token: _user.token);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  /*
   * authenticate user by his phone number and password
   */

  /*
   * Update user profile info
   */
  Future<void> updateUserProfile(
      {@required String fullName,
      @required String email,
      @required String mobile,
      String password}) async {
    try {
      //TODO:update profile implementation
    } catch (e) {
      Logger().e(e);
    }
  }

  /*
   *check if user is authenticated 
   */
  bool get userLoged => Preference.getBool(PrefKeys.userLogged) ?? false;

  StreamController<User> _userController = StreamController<User>();

  Future<bool> login(int userId) async {
    var fetchedUser = await api.getUser(userId);
  }

  /*
   * load the user info from shared prefrence if existed to be used in the service   
   */
  Future<void> get loadUser async {
    if (userLoged) {
      _user =
          User.fromJson(json.decode(Preference.getString(PrefKeys.userData)));
      Logger().i(_user.toJson());
      print('\n\n\n');
    }
  }

  /*
   * signout the user from the app and return to the login screen   
   */
  Future<void> get signOut async {
    await Preference.remove(PrefKeys.userData);
    await Preference.remove(PrefKeys.userLogged);
    await Preference.remove(PrefKeys.fcmToken);
    await Preference.remove(PrefKeys.token);

    _user = null;
  }

  static handleAuthExpired({@required BuildContext context}) async {
    if (context != null) {
      try {
        await Preference.clear();

        UI.pushReplaceAll(context, Routes.splash);

        Logger().i('🦄session destroyed🦄');
      } catch (e) {
        Logger().v('🦄error while destroying session $e🦄');
      }
    }
  }
}

void saveUser({User user}) {}

void saveUserToken({String token}) {}
