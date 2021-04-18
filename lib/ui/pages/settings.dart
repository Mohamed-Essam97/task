import 'dart:io';

import 'package:base_notifier/base_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/ui/pages/webView.dart';
import 'package:testapp/ui/widgets/buttons/normal_button.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:wifi/wifi.dart';

class SettingsPage extends StatelessWidget {
  User user;
  SettingsPage({this.user});
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return BaseWidget<SettingsPageModel>(
        initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) {
              m.checkPortRange('192.168.0', 80, 200);
            }),
        model: SettingsPageModel(context: context),
        builder: (context, model, _child) => Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
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
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                      Text("You Have ${model.devices.length} Device"),
                      DropdownButton<String>(
                          items: model.devices.map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: new Text(val),
                            );
                          }).toList(),
                          hint: Text(dropdownValue),
                          onChanged: (String val) {
                            dropdownValue = val;
                            model.setState();
                          })
                    ],
                  ),
                ),
              ),
            ));
  }

  String dropdownValue = "Choose";
}

class SettingsPageModel extends BaseNotifier {
  final BuildContext context;

  SettingsPageModel({
    NotifierState state,
    this.context,
  }) : super(state: state);

  void checkPortRange(String subnet, int fromPort, int toPort) async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 80;

    final stream = NetworkAnalyzer.discover2(subnet, port);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
        devices.add(addr.ip);
        setState();
      }
    });
  }

  List<String> devices = [];

  // void _testConnection(
  //   final http.Client client,
  //   final String ip,
  // ) async {
  //   try {
  //     final response = await client.get(Uri.parse('http://$ip/helloWorld'));

  //     if (response.statusCode == 200) {
  //       if (!response.body.startsWith("<")) {
  //         if (!devices.contains(ip)) {
  //           print('Found a device with ip $ip! Adding it to list of devices');
  //           List<Device> containedDevices = [];
  //           for (Device device in devices) {
  //             if (device.ipAddress.compareTo(ip) == 0) {
  //               containedDevices.add(device);
  //             }
  //           }

  //           if (containedDevices.length == 0) {
  //             devices.add(
  //               Device(ip),
  //             );
  //             setState();
  //           }
  //         }
  //       }
  //     }
  //   } on SocketException catch (e) {
  //     //NOP
  //   }
  // }

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
