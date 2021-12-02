import 'package:flutter/material.dart';
import 'package:whatsapp_replika/models/StatusModel.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            // This Padding is for user's status
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 11,
                        backgroundColor: Color(0xff25D366),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  margin: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text("Tap to add status update"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            // this padding is for recent updates
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Recent updates",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            //this container is for showing recent update list
            child: StatusModelListUnseen(),
          ),
          Padding(
            // this padding is for viewed updates
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Viewed updates",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            //this container is for showing viewed update list
            child: StatusModelListSeen(),
          ),
        ],
      ),
    );
  }
}

class StatusModelListUnseen extends StatelessWidget {
  const StatusModelListUnseen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          StatusModel(name: "Furkan Aydemir", postDate: "15 minutes ago"),
          StatusModel(
              name: "Özüm Düvenci", postDate: "Today, 6:53 in the evening"),
          StatusModel(
              name: "Nazif Göymen", postDate: "Today, 6:45 in the evening")
        ],
      ),
    );
  }
}

class StatusModelListSeen extends StatelessWidget {
  const StatusModelListSeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          StatusModel(
              name: "Mehmet Küpeli", postDate: "Today, 3:05 in the afternoon"),
          StatusModel(
              name: "Cem İşeri", postDate: "Today, 1:29 in the afternoon")
        ],
      ),
    );
  }
}
