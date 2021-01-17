import 'package:flutter/material.dart';
import 'package:whatsapp/animations/signin_animation.dart';
import 'package:whatsapp/components/Form.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:whatsapp/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _LoginButtonController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _emailValue;
  String _passwordValue;

  emailOnSaved(String value) {
    _emailValue = value;
  }

  passwordOnSaved(String value) {
    _passwordValue = value;
  }

  @override
  void initState() {
    super.initState();
    _LoginButtonController = new AnimationController(
      duration: new Duration(microseconds: 30000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _LoginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = .4;
    var page = MediaQuery.of(context).size;

    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            const Color(0xff2c5364),
            const Color(0xff0f2027),
          ],
        )),
        child: new Stack(
          alignment: Alignment.bottomCenter,
          children: [
            new Opacity(
              opacity: .1,
              child: new Container(
                width: page.width,
                height: page.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            new AssetImage("assets/images/icon-background.png"),
                        repeat: ImageRepeat.repeat)),
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormContainer(
                    formKey: _formKey,
                    emailOnSaved: emailOnSaved,
                    passwordOnSaved: passwordOnSaved),
                new FlatButton(
                    onPressed: null,
                    child: new Text(
                      "عضویت",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.5,
                          fontSize: 14),
                    ))
              ],
            ),
            new GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  sendDataForLogin();
                }
              },
              child: new SignInAnimation(
                controller: _LoginButtonController.view,
              ),
            )
          ],
        ),
      ),
    );
  }

  sendDataForLogin() async {
    await _LoginButtonController.animateTo(0.150);
    Map response = await (new AuthService())
        .sendDataToLogin(({"email": _emailValue, "password": _passwordValue}));
    print(response);
    if (response['status'] == 'success') {
      await storeUserData(response['data']);
      await _LoginButtonController.forward();
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      await _LoginButtonController.reverse();
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
            content: new Text(
          response['data'],
          style: TextStyle(fontFamily: 'Vazir'),
        )),
      );
    }
    // await _LoginButtonController.forward();
    // await _LoginButtonController.reverse();
  }

  storeUserData(Map userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData['api_token']);
    await prefs.setInt('user.api_id', userData['user_id']);
  }
}
