import 'package:flutter/material.dart';

import 'TabBarScreens/tabBar_CameraScreen.dart';
import 'TabBarScreens/tabBar_ChatsScreen.dart';
import 'TabBarScreens/tabBar_StatusScreen.dart';
import 'TabBarScreens/tabBart_CallsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WhatsApp Replika",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      home: Iskele(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Iskele extends StatefulWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  _IskeleState createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  static const List<Tab> _tabs = [
    Tab(icon: Icon(Icons.camera_alt)),
    Tab(text: "Chats"),
    Tab(text: "Status"),
    Tab(text: "Calls"),
  ];

  static const List<Widget> _pages = <Widget>[
    CameraScreen(),
    ChatsScreen(),
    StatusScreen(),
    CallsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // özellik eklenecek
                },
              ),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(child: Text('New Group')),
                    const PopupMenuItem(child: Text('New Broadcast')),
                    const PopupMenuItem(child: Text('Linked Devices')),
                    const PopupMenuItem(child: Text('Starred Messages')),
                    const PopupMenuItem(child: Text('Settings')),
                  ];
                },
              ),
            ],
            title: Text("WhatsApp Replika"),
            bottom: TabBar(
              tabs: _tabs,
            ),
          ),
          body: TabBarView(
            children: _pages,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () => print("open chats"),
          )),
    );
  }
}
