import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_replika/models/ChatModel.dart';
import 'package:whatsapp_replika/view/PrivateChat/PrivateChatScreen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatLine> chatInfos = new List.empty();

  final db = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  fetchData() {
    FirebaseFirestore.instance
        .collection("messages")
        .doc(currentUser!.uid)
        .get()
        .then((data) {
      if (data.exists) {
      } else {
        return Center(child: Text("Welcome ${currentUser!.uid}"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
        stream:
            db.collection('Users').snapshots(), //to do fix it with currentUser.
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return new ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PrivateChatScreen(
                                    document: doc,
                                  )));
                    },
                    child: ChatLine(
                      contactName: doc['username'],
                      mostRecentMessage: 'Tap to chat',
                      seenDate: '',
                    ),
                  );
                });
        },
      ),
    );
  }
}
