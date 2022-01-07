import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactProfileScreenFirstContainer extends StatefulWidget {
  final QueryDocumentSnapshot document;
  const ContactProfileScreenFirstContainer({Key? key, required this.document})
      : super(key: key);

  @override
  _ContactProfileScreenFirstContainerState createState() =>
      _ContactProfileScreenFirstContainerState(this.document);
}

class _ContactProfileScreenFirstContainerState
    extends State<ContactProfileScreenFirstContainer> {
  _ContactProfileScreenFirstContainerState(QueryDocumentSnapshot doc) {
    this.document = doc;
  }
  late QueryDocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blueGrey,
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Color(0xff075E54),
              radius: 100,
              child: Text(
                (this.document['username'][0]),
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
          Column(children: [
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(8),
              child: Row(children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back)),
                Spacer(),
                PopupMenuButton(itemBuilder: (context) {
                  return [
                    const PopupMenuItem(child: Text('Share')),
                    const PopupMenuItem(child: Text('Edit')),
                    const PopupMenuItem(child: Text('View in address book')),
                    const PopupMenuItem(child: Text('Verify security code')),
                  ];
                }),
              ]),
            ),
            Spacer(),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(15),
              child: Text(
                (this.document['username']),
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class MediaExample extends StatelessWidget {
  const MediaExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      height: 50,
      width: 50,
    );
  }
}

class ContactProfileScreenSecondContainer extends StatelessWidget {
  const ContactProfileScreenSecondContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder()),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Media, links, and docs",
              ),
              Spacer(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [Text("100"), Icon(Icons.keyboard_arrow_right)],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediaExample(),
              MediaExample(),
              MediaExample(),
              MediaExample(),
              MediaExample(),
              MediaExample(),
              MediaExample(),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactProfileScreenThirdContainer extends StatefulWidget {
  const ContactProfileScreenThirdContainer({Key? key}) : super(key: key);

  @override
  _ContactProfileScreenThirdContainerState createState() =>
      _ContactProfileScreenThirdContainerState();
}

class _ContactProfileScreenThirdContainerState
    extends State<ContactProfileScreenThirdContainer> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder()),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Text(
                  "Mute notifications",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Switch(
                  activeColor: Color(0xff25D366),
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Text(
                  "Custom notifications",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Text(
                  "Media visibility",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContactProfileScreenFourthContainer extends StatelessWidget {
  const ContactProfileScreenFourthContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder()),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Disappearing messages",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Off",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.av_timer)
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Encryption",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Messages and calls are end-to-end encrypted.",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  Text(
                    "Tap to verify",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )
                ],
              ),
              Spacer(),
              Icon(Icons.lock)
            ],
          ),
        ],
      ),
    );
  }
}

class ContactProfileScreenFifthContainer extends StatelessWidget {
  const ContactProfileScreenFifthContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder()),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About and phone number",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            "Hey there, I'm using WhatsApp Replika!",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 5),
          Text(
            "January 22",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("0555 555 55 55", style: TextStyle(fontSize: 20)),
                  Text("Mobile", style: TextStyle(color: Colors.grey)),
                ],
              ),
              Spacer(),
              Icon(
                Icons.message,
                color: Color(0xff25D366),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.call,
                color: Color(0xff25D366),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.videocam_sharp,
                color: Color(0xff25D366),
              )
            ],
          )
        ],
      ),
    );
  }
}
