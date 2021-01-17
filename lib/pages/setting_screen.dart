import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl, 
      child:  Scaffold(
      appBar: new AppBar(
        title : Text('تنظیمات')
        
      ),
      body: new Center(
        child : new Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
              new Text("تنظیمات", style: TextStyle(fontSize: 20 ) ,) ,
              new RaisedButton(
                    onPressed: ()=> Navigator.pop(context) ,
                    child: new Text('برگشت')
                    )
                ],
        ),
      ),
    )
    );
  }
  
}