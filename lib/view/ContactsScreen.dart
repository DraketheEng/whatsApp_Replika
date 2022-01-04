import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_replika/view/PrivateChat/PrivateChatScreen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<ContactInfo> contactInfos = new List.empty();

  final db = FirebaseFirestore.instance;

  fetchData() {
    FirebaseFirestore.instance.collection("Users").doc().get().then((data) {
      List<ContactInfo> contacts = new List.empty();

      var docs = data.data();

      docs!.forEach((key, value) {
        ContactInfo contactInfo =
            new ContactInfo(contactName: value.username, contactState: '');
        contacts.add(contactInfo);
      });

      setState(() {
        contactInfos.addAll(contacts);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: customIcon,
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.close);
                    _appBarTitle = Container(
                      height: 35,
                      child: new TextField(
                        controller: _filter,
                        decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff25D366)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff25D366)),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: new Icon(
                            Icons.search,
                            color: Color(0xff25D366),
                          ),
                          hintText: 'Search...',
                        ),
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
            PopupMenuButton(itemBuilder: (context) {
              return [
                const PopupMenuItem(child: Text('Invite a friend')),
                const PopupMenuItem(child: Text('Contacts')),
                const PopupMenuItem(child: Text('Refresh')),
                const PopupMenuItem(child: Text('Help')),
              ];
            })
          ],
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          title: _appBarTitle),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xff25D366),
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                margin: EdgeInsets.all(8),
                child: Text(
                  "New group",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xff25D366),
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                margin: EdgeInsets.all(8),
                child: Text(
                  "New contact",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('Users').snapshots(),
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
                          child: ContactInfo(
                              contactName: doc['username'],
                              contactState:
                                  "Hi there, I'm using WhatsApp Replika"),
                        );
                      });
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  String contactName;

  String contactState;

  ContactInfo({Key? key, required this.contactName, required this.contactState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(contactName[0]),
        ),
        Container(
          padding: EdgeInsets.only(left: 8),
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contactName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                contactState,
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget _appBarTitle = new Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Text(
      "Select Contact",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    Text(
      "28 Contacts",
      style: TextStyle(fontSize: 13),
    )
  ],
);

final TextEditingController _filter = new TextEditingController();

Icon customIcon = const Icon(Icons.search);
