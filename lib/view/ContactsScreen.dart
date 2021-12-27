import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
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
        title: Column(
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
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
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
          ContactInfo(),
        ]),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text("C"),
        ),
        Container(
          padding: EdgeInsets.only(left: 8),
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Hey there! I am using WhatsApp Replika!",
              )
            ],
          ),
        ),
      ],
    );
  }
}
