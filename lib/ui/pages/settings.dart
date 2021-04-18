import 'package:base_notifier/base_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/ui/pages/webView.dart';
import 'package:testapp/ui/widgets/buttons/normal_button.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:ui_utils/ui_utils.dart';

class SettingsPage extends StatelessWidget {
  User user;
  SettingsPage({this.user});
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return BaseWidget<SettingsPageModel>(
        model: SettingsPageModel(context: context),
        builder: (context, model, _child) => Scaffold(
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: user.photoURL,
                        imageBuilder: (context, imageProvider) => Container(
                          width: screenWidth / 3,
                          height: screenWidth / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.displayName,
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: myController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter URL ',
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 6.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: NormalButton(
                        text: "GO TO WEBSITE",
                        color: Colors.blue[800],
                        onPressed: () {
                          myController.text.isEmpty
                              ? UI.toast("please enter url")
                              : UI.push(
                                  context,
                                  WebViewPage(
                                    webUrl: myController.text,
                                  ));
                        },
                        height: 30,
                        // width: 80,
                        raduis: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

class SettingsPageModel extends BaseNotifier {
  final BuildContext context;

  SettingsPageModel({
    NotifierState state,
    this.context,
  }) : super(state: state);

//   fun() async{
//   final String ip = await Wifi.ip;
// final String subnet = ip.substring(0, ip.lastIndexOf('.'));
// final int port = 80;

// final stream = NetworkAnalyzer.discover2(subnet, port);
// stream.listen((NetworkAddress addr) {
//   if (addr.exists) {
//     print('Found device: ${addr.ip}');
//   }
// });
//   }
}
