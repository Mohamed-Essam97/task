import 'package:base_notifier/base_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/core/services/api/http_api.dart';
import 'package:testapp/core/services/localization/localization.dart';
import 'package:testapp/ui/pages/settings.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithSocial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // navigate(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BaseWidget<LoginWithSocialModel>(

        // initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) {
        //       m.checkUser();
        //     }),
        model: LoginWithSocialModel(context: context),
        builder: (context, model, _child) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/images/logo.png"),
                        SizedBox(
                          height: screenHeight * 0.2,
                        ),
                        InkWell(
                          onTap: () async {
                            await model.signInWithFacbook(context);
                          },
                          child: card(
                              "Log In with Facebook",
                              "assets/images/facebook.svg",
                              Colors.white,
                              context,
                              Colors.blue[800],
                              Colors.blue[800]),
                        ),
                        InkWell(
                          onTap: () async {
                            await model.signInWithGoogle(context);
                          },
                          child: card(
                              "Log In with Google",
                              "assets/images/gmail.svg",
                              Colors.red[800],
                              context,
                              Colors.red[800],
                              Colors.white),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        InkWell(
                          onTap: () async {
                            UI.push(context, SettingsPage());
                          },
                          child: card(
                              "Enter without login",
                              "asssetsds/images/facebook.svg",
                              Colors.white,
                              context,
                              Colors.green,
                              Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget card(
      name, String icon, color, BuildContext context, bordercColor, textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //                 <--- border radius here
              ),
          border: Border.all(
            color: bordercColor,
            width: 2,
          ),
          // borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                icon,
                width: 25,
              ),
              SizedBox(
                width: 90,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginWithSocialModel extends BaseNotifier {
  final BuildContext context;

  LoginWithSocialModel({
    NotifierState state,
    this.context,
  }) : super(state: state);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle(BuildContext context) async {
    setBusy();

    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      setError();
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      //Action
      UI.push(
          context,
          SettingsPage(
            user: user,
          ));

      // authenticateUser(context, user, "google");
    } else {
      UI.toast("Error");
      // UI.toast(locale.get("Error") ?? "Error");
      setError();
    }
  }

  void signInWithFacbook(BuildContext context) async {
    setBusy();

    final facebookLogin = FacebookLogin();

    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        UI.toast("logged in");

        final FacebookAccessToken accessToken = result.accessToken;

        print("Access Token : " + accessToken.token);
        print("Access Token : " + accessToken.userId);
        // Create a credential from the access token
        final FacebookAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);

        // Once signed in, return the UserCredential
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        final User user = userCredential.user;
        if (user != null) {
          // Action
          // authenticateUser(context, user, "facebook");
          UI.push(
              context,
              SettingsPage(
                user: user,
              ));
        } else {
          // UI.toast(locale.get("Error") ?? "Error");
          UI.toast("error");
          setError();
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        UI.toast("Cancel");
        setError();

        // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        UI.toast("Error");
        setError();

        // _showErrorOnUI(result.errorMessage);
        break;
    }
  }
}
