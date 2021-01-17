import 'package:flutter/material.dart';

class SignInAnimation extends StatelessWidget{
         final Animation<double> controller;
         final Animation <double> buttonSqueezeAnimation;
         final Animation <double> buttonZoomOut;
         
         SignInAnimation({this.controller}) : 
          buttonSqueezeAnimation = new Tween(
           begin: 280.0,
           end: 60.0 
          ).animate(
            CurvedAnimation(
              parent: controller,
               curve: Interval(0.0, 0.150))
          ),
          buttonZoomOut = new Tween(
           begin: 70.0,
           end: 1000.0 
          ).animate(new CurvedAnimation(parent:controller
           , curve: Interval(0.550, 0.999 ,curve: Curves.bounceOut) ));


  Widget _animationBuilder (BuildContext context , Widget child){
          return buttonZoomOut.value <= 300
        ? new Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: buttonZoomOut.value == 70
              ? buttonSqueezeAnimation.value
              : buttonZoomOut.value,
            height: buttonZoomOut.value == 70
              ? 60
              : buttonZoomOut.value,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                      color: new Color(0xff075e54),
                      borderRadius: buttonZoomOut.value < 400
                      ?  new BorderRadius.all(Radius.circular(30))
                      : new BorderRadius.all(Radius.circular(0))
            ) ,
            child: buttonSqueezeAnimation.value >75
            ? new Text(
              'ورود',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3 
              ), 
            )
            : buttonZoomOut.value < 300
              ? new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)
              )
              : null,
          )
        :  new Container(
          width: buttonZoomOut.value,
          height: buttonZoomOut.value,
          decoration: BoxDecoration(
            shape: buttonZoomOut.value <500 
            ? BoxShape.circle
            : BoxShape.rectangle ,
            color: Color(0xff075e54)
          ), 
        );
       
  }
  @override
  Widget build(BuildContext context) {
      return new AnimatedBuilder(
        animation: controller, 
        builder: _animationBuilder);

  }

}