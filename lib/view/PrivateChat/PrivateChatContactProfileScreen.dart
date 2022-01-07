import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ContactProfileScreenModels.dart';

class PrivateChatContactProfileScreen extends StatefulWidget {
  final QueryDocumentSnapshot document;
  const PrivateChatContactProfileScreen({Key? key, required this.document})
      : super(key: key);

  @override
  _PrivateChatContactProfileScreenState createState() =>
      _PrivateChatContactProfileScreenState(this.document);
}

class _PrivateChatContactProfileScreenState
    extends State<PrivateChatContactProfileScreen> {
  _PrivateChatContactProfileScreenState(QueryDocumentSnapshot doc) {
    this.document = doc;
  }

  late QueryDocumentSnapshot document;

  @override
  final db = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: ListView(
          children: [
            ContactProfileScreenFirstContainer(
                document: this.document), //Bu container profil resmi içindir.
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
