import 'package:flutter/material.dart';

import 'ContactProfileScreenModels.dart';

class PrivateChatContactProfileScreen extends StatefulWidget {
  const PrivateChatContactProfileScreen({Key? key}) : super(key: key);

  @override
  _PrivateChatContactProfileScreenState createState() =>
      _PrivateChatContactProfileScreenState();
}

class _PrivateChatContactProfileScreenState
    extends State<PrivateChatContactProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: ListView(
          children: [
            ContactProfileScreenFirstContainer(), //Bu container profil resmi içindir.
            ContactProfileScreenSecondContainer(), //Bu container media bağlantı ve belgeleri içerir
            ContactProfileScreenThirdContainer(), //Bu container bildirimler için seçenekler içerir
            ContactProfileScreenFourthContainer(), //Bu container kaybolan mesaj ve şifreleme içerir
            ContactProfileScreenFifthContainer(), //Bu container telefon numarası ve durum içerir
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.white, shape: RoundedRectangleBorder()),
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: Row(children: [
                Icon(
                  Icons.block,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  "Block",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ]),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.white, shape: RoundedRectangleBorder()),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding: EdgeInsets.all(10),
              child: Row(children: [
                Icon(
                  Icons.thumb_down,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  "Report contact",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
