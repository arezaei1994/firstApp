import 'package:flutter/material.dart';

class NewGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl, 
      child:  Scaffold(
      appBar: new AppBar(
        title : Text('گروه جدید')
      ),
      body: new Center(
        child : new Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
              new Text("گروه جدید", style: TextStyle(fontSize: 20 ) ,) ,
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