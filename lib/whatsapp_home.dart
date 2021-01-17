import 'package:flutter/material.dart';
import 'package:whatsapp/pages/call_screen.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/pages/chat_screen.dart';
import 'package:whatsapp/pages/new_group.dart';
import 'package:whatsapp/pages/create_chat_screen.dart';
import 'package:whatsapp/pages/products_screen.dart';
import 'package:whatsapp/pages/setting_screen.dart';

class WhatsAppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new WhatsAppHomeState();
}

class WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Map<String, SliverAppBar> appBarList;
  String _cuurentappbar = 'mainAppBar';

  @override
  void initState() {
    super.initState();

    tabController = new TabController(initialIndex: 1, length: 4, vsync: this);
    SliverAppBar mainAppBar = new SliverAppBar(
      automaticallyImplyLeading: false,
      title: new Text("واتساپ"),
      elevation: 5,
      pinned: true,
      floating: true,
      bottom: new TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.camera_alt)),
            new Tab(text: "چت ها"),
            new Tab(text: "محصولات"),
            new Tab(text: "تماس ها")
          ]),
      actions: <Widget>[
        new GestureDetector(
          child: Icon(Icons.search),
          onTap: () {
            setState(() {
              _cuurentappbar = 'searchAppBar';
            });
          },
        ),
        new Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
        new PopupMenuButton<String>(onSelected: (String choice) {
          if (choice == 'settings') {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => SettingsScreen()));
          } else if (choice == 'new_group') {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => NewGroup()));
          }
          ;
        }, itemBuilder: (BuildContext context) {
          return [
            new PopupMenuItem(
                value: 'new_group',
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[new Text('گروه جدید')],
                )),
            new PopupMenuItem(
                value: 'settings',
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[new Text('تنظیمات')],
                ))
          ];
        })
      ],
    );
    SliverAppBar searchAppBar = new SliverAppBar(
      title: new TextField(
        decoration:
            new InputDecoration(border: InputBorder.none, hintText: 'جستجو '),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
      pinned: true,
      leading: new GestureDetector(
        child: new Icon(Icons.arrow_back, color: new Color(0xff075e54)),
        onTap: () {
          setState(() {
            _cuurentappbar = 'mainAppBar';
          });
        },
      ),
    );
    appBarList = <String, SliverAppBar>{
      'mainAppBar': mainAppBar,
      'searchAppBar': searchAppBar
    };
  }

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (context) {
              return new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new AlertDialog(
                    title: new Text("آیا از خروج مطمئنین؟"),
                    content:
                        new Text("با انتخاب گزینه بله از اپ خارج خواهید شد"),
                    actions: [
                      new FlatButton(
                          onPressed: null,
                          child: new Text(
                            "بله",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )),
                      new FlatButton(
                          onPressed: null,
                          child: new Text(
                            "خیر",
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ));
            }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
          body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[appBarList[_cuurentappbar]];
            },
            body: _cuurentappbar == 'mainAppBar'
                ? new TabBarView(controller: tabController, children: <Widget>[
                    new CameraScreen(),
                    new ChatScreen(),
                    new ProductsScreen(),
                    new CallScreen()
                  ])
                : new TabBarView(controller: tabController, children: <Widget>[
                    new CameraScreen(),
                    new ChatScreen(),
                    new ProductsScreen(),
                    new CallScreen()
                  ]),
          ),
          floatingActionButton: new FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: new Icon(Icons.message, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CreateChatScreen()));
              }),
        ),
        onWillPop: _onWillPop);
  }
}
