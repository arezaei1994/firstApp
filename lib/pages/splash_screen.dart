import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:whatsapp/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  navigationToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff075e54),
        body: new Stack(
          fit: StackFit.expand,
          children: [
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage(
                            "assets/images/whatsapp_start_screen.png")),
                  ),
                ),
                new Text(
                  'واتساپ',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: new Align(
                alignment: Alignment.bottomCenter,
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = await prefs.getString('user.api_token');

    //   if(apiToken==null) navigationToLogin();
    if (await checkConnectionInternet()) {
      await AuthService.checkApiToken(apiToken)
          ? navigationToHome()
          : navigationToLogin();
    } else {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: new Duration(hours: 2),
          content: new GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
              checkLogin();
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Text('از اتصال اینترنت خود مطمئن شوید'),
                new Icon(
                  Icons.wifi_lock,
                  color: Colors.white,
                )
              ],
            ),
          )));
    }
  }

  Future<bool> checkConnectionInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  navigationToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
