import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_replika/view/PrivateChat/PrivateChatContactProfileScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PrivateChatScreen extends StatefulWidget {
  final QueryDocumentSnapshot document;

  const PrivateChatScreen({Key? key, required this.document}) : super(key: key);

  @override
  _PrivateChatScreenState createState() =>
      _PrivateChatScreenState(this.document);
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  _PrivateChatScreenState(QueryDocumentSnapshot doc) {
    this.document = doc;
  }

  TextEditingController t1 = TextEditingController();

  late QueryDocumentSnapshot document;

  addMessage(String text) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection("messages")
        .doc(currentUser?.uid)
        .collection(document.id)
        .doc()
        .set(({
          "senderId": currentUser!.uid,
          "receiverId": document.id,
          "imageURL": "",
          "messageText": text,
          "time": DateTime.now().millisecondsSinceEpoch
        }));

    FirebaseFirestore.instance
        .collection("messages")
        .doc(document.id)
        .collection(currentUser.uid)
        .doc()
        .set(({
          "senderId": currentUser.uid,
          "receiverId": document.id,
          "imageURL": "",
          "messageText": text,
          "time": DateTime.now().millisecondsSinceEpoch
        }));
    t1.clear();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                child: Text(this.document['username'][0]),
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PrivateChatContactProfileScreen(
                          document: this.document,
                        )));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.document['username'],
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Online",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem(child: Text('View Contact')),
              const PopupMenuItem(child: Text('Media, links, and docs')),
              const PopupMenuItem(child: Text('WhatsApp Web')),
              const PopupMenuItem(child: Text('Search')),
              const PopupMenuItem(child: Text('Mute Notification')),
              const PopupMenuItem(child: Text('Wallpaper')),
            ];
          })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('messages')
                    .doc(currentUser!.uid)
                    .collection(this.document.id)
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return new ListView.builder(
                        shrinkWrap: false,
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data!.docs[index];

                          return InkWell(
                            child: MessageBalloon(
                              message: doc['messageText'],
                              time: doc['time'],
                              document: doc,
                            ),
                          );
                        });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 2),
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 55,
                        child: Card(
                          margin: EdgeInsets.only(bottom: 8, left: 2, right: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            controller: t1,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              prefixIcon: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return BottomClass(
                                          document: document,
                                        );
                                      });
                                },
                                icon: Icon(Icons.attach_file,
                                    color: Color(0xff075E54)),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  addMessage(t1.text);
                                },
                                icon:
                                    Icon(Icons.send, color: Color(0xff075E54)),
                              ),
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, left: 2, right: 2),
                        child: CircleAvatar(
                          backgroundColor: Color(0xff25D366),
                          child: IconButton(
                            icon: Icon(Icons.mic),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBalloon extends StatefulWidget {
  final QueryDocumentSnapshot document;
  var message;
  var time;

  MessageBalloon({required this.message, this.time, required this.document});

  @override
  _MessageBalloonState createState() => _MessageBalloonState();
}

class _MessageBalloonState extends State<MessageBalloon> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var dateNow = new DateTime.now();
    var date = new DateTime.fromMicrosecondsSinceEpoch(this.widget.time * 1000);
    String formattedDate = DateFormat('dd/M/yyyy ??? HH:mm').format(date);
    final difference = dateNow.difference(date).inDays;
    if (difference < 1) {
      formattedDate = DateFormat("'Today' - HH:mm").format(date);
    } else if (difference < 2) {
      formattedDate = DateFormat("'Yesterday' - HH:mm").format(date);
    }
    var ballonColor = Colors.white;
    var ballonAlignment = Alignment.centerLeft;
    if (currentUser!.uid == widget.document['senderId']) {
      ballonColor = Colors.deepPurple.shade200;
      ballonAlignment = Alignment.centerRight;
    }

    return Container(
      alignment: ballonAlignment,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: Container(
          width: 200,
          decoration: ShapeDecoration(
              color: ballonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Expanded(
              child: Column(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.all(5),
                    child: (widget.document["imageURL"] == null ||
                            widget.document["imageURL"] == "")
                        ? Text(widget.message, style: TextStyle(fontSize: 15))
                        : Image.network(widget.document["imageURL"])),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(formattedDate.toString(),
                          style: TextStyle(fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      //  Icon(
                      //    Icons.done_all,
                      //    color: Colors.blue.shade300,
                      //   ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomClass extends StatefulWidget {
  final QueryDocumentSnapshot document;
  const BottomClass({Key? key, required this.document}) : super(key: key);

  @override
  _BottomClassState createState() => _BottomClassState(this.document);
}

class _BottomClassState extends State<BottomClass> {
  _BottomClassState(QueryDocumentSnapshot doc) {
    this.document = doc;
  }

  User? currentUser = FirebaseAuth.instance.currentUser;
  late File _image;
  late QueryDocumentSnapshot document;

  final _storage = FirebaseStorage.instance;

  Future getImagefromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    var file = File(image!.path);
    if (image != null) {
      var snapshot = await _storage
          .ref()
          .child("${currentUser!.uid}/${image.name}")
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("messages")
          .doc(currentUser?.uid)
          .collection(document.id)
          .doc()
          .set(({
            "senderId": currentUser!.uid,
            "receiverId": document.id,
            "imageURL": downloadUrl,
            "messageText": "",
            "time": DateTime.now().millisecondsSinceEpoch
          }));
      FirebaseFirestore.instance
          .collection("messages")
          .doc(document.id)
          .collection(currentUser!.uid)
          .doc()
          .set(({
            "senderId": currentUser!.uid,
            "receiverId": document.id,
            "imageURL": downloadUrl,
            "messageText": "",
            "time": DateTime.now().millisecondsSinceEpoch
          }));
    } else {
      print("No path recieved.");
    }
    setState(() => this._image = file);
  }

  Future getImagefromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    var file = File(image!.path);
    if (image != null) {
      var snapshot = await _storage
          .ref()
          .child("${currentUser!.uid}/${image.name}")
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("messages")
          .doc(currentUser?.uid)
          .collection(document.id)
          .doc()
          .set(({
            "senderId": currentUser!.uid,
            "receiverId": document.id,
            "imageURL": downloadUrl,
            "messageText": "",
            "time": DateTime.now().millisecondsSinceEpoch
          }));
      FirebaseFirestore.instance
          .collection("messages")
          .doc(document.id)
          .collection(currentUser!.uid)
          .doc()
          .set(({
            "senderId": currentUser!.uid,
            "receiverId": document.id,
            "imageURL": downloadUrl,
            "messageText": "",
            "time": DateTime.now().millisecondsSinceEpoch
          }));
    } else {
      print("No path recieved.");
    }
    setState(() => this._image = file);
  }

  Widget bottomSheet() {
    return Container(
      height: 275,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: BottomSheetItems(
                    bottomSheetItemIcon: Icons.insert_drive_file_sharp,
                    bottomSheetItemText: "Document",
                    bottomSheetItemColor: Colors.indigo,
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImagefromCamera();
                  },
                  child: BottomSheetItems(
                    bottomSheetItemIcon: Icons.camera_alt,
                    bottomSheetItemText: "Camera",
                    bottomSheetItemColor: Colors.pink,
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImagefromGallery();
                  },
                  child: BottomSheetItems(
                    bottomSheetItemIcon: Icons.insert_photo,
                    bottomSheetItemText: "Gallery",
                    bottomSheetItemColor: Colors.purple,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: BottomSheetItems(
                    bottomSheetItemIcon: Icons.headset,
                    bottomSheetItemText: "Audio",
                    bottomSheetItemColor: Colors.orange,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: BottomSheetItems(
                    bottomSheetItemIcon: Icons.location_pin,
                    bottomSheetItemText: "Location",
                    bottomSheetItemColor: Colors.pink,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: BottomSheetItems(
                    bottomSheetItemIcon: Icons.person,
                    bottomSheetItemText: "Contact",
                    bottomSheetItemColor: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return bottomSheet();
  }
}

class BottomSheetItems extends StatelessWidget {
  BottomSheetItems(
      {Key? key,
      required this.bottomSheetItemIcon,
      required this.bottomSheetItemText,
      required this.bottomSheetItemColor})
      : super(key: key);

  IconData bottomSheetItemIcon;
  String bottomSheetItemText;
  Color bottomSheetItemColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: bottomSheetItemColor,
            radius: 30,
            child: Icon(bottomSheetItemIcon),
          ),
          Text(bottomSheetItemText)
        ],
      ),
    );
  }
}
