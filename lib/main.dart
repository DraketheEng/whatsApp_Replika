import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_replika/view/ContactsScreen.dart';
import 'package:whatsapp_replika/view/TabBarScreens/tabBar_CameraScreen.dart';
import 'package:whatsapp_replika/view/TabBarScreens/tabBar_ChatsScreen.dart';
import 'package:whatsapp_replika/view/TabBarScreens/tabBar_StatusScreen.dart';
import 'package:whatsapp_replika/view/TabBarScreens/tabBart_CallsScreen.dart';
import 'package:whatsapp_replika/view/signUp_and_LoginScreens/loginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WhatsApp Replika",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Iskele extends StatefulWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  _IskeleState createState() => _IskeleState();
}

Icon customIcon = const Icon(Icons.search);

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
                icon: customIcon,
                onPressed: () {
                  setState(() {
                    if (customIcon.icon == Icons.search) {
                      customIcon = const Icon(Icons.close);
                      _appBarTitle = new TextField(
                        controller: _filter,
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: new Icon(Icons.search),
                          hintText: 'Search...',
                        ),
                      );
                    } else {
                      customIcon = const Icon(Icons.search);
                      _appBarTitle = new Text('WhatsApp Replika');
                      _filter.clear();
                    }
                  });
                },
              ),
              IconButton(
                  onPressed: () async {
                    await _signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                          (Route<dynamic> route) => false);
                    });
                  },
                  icon: Icon(Icons.exit_to_app)),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
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
            title: _appBarTitle,
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
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ContactsScreen())),
          )),
    );
  }
}

Widget _appBarTitle = new Text('WhatsApp Replika');

final TextEditingController _filter = new TextEditingController();

_signOut() async {
  await FirebaseAuth.instance.signOut();
}
