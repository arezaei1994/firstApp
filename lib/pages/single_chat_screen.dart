import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/pages/camera_screen.dart';

class SingleChatScreen extends StatelessWidget {

  final ChatModel data;
  SingleChatScreen({@required this.data});

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl, 
      child:  Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title : new Row(
          children: [
            new GestureDetector(
              onTap: ()=> Navigator.pop(context),
              child: new Icon(Icons.arrow_back)
              ),
            new SizedBox(width : 5),
            new CircleAvatar(backgroundColor: new Color(0xff888888),),
            new SizedBox(width : 5),
            new Text(this.data.name ,style: TextStyle(fontSize : 16),)
          ],
        ),
        
      ),
      body: new Center(
        child : new Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
              new Text("صفحه چت " + this.data.name , style: TextStyle(fontSize: 20 ) ,) ,
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new RaisedButton(
                    onPressed: ()=> Navigator.push(
                      context,
                       new MaterialPageRoute(
                         builder: (context)=> CameraScreen()
                          )
                         ),
                    child: new Text('صفحه دوم')
                    ),
                     new RaisedButton(
                    onPressed: ()=> Navigator.pop(context ,"برگشت از ${this.data.name}") ,
                    child: new Text('برگشت')
                    )
                ],
              )      
                ],
        ),
      ),
    )
    );
  }
  
}