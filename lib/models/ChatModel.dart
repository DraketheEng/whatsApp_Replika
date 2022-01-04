import 'package:flutter/material.dart';
import 'package:whatsapp_replika/view/PrivateChat/PrivateChatScreen.dart';

late final Satir satir;

class Satir extends StatelessWidget {
  String name;
  String mostRecentMessage;
  String seenDate;
  IconData seenStatus;
  Color seenStatusColor;

  Satir(
      {Key? key,
      required this.name,
      required this.mostRecentMessage,
      required this.seenDate,
      required this.seenStatus,
      required this.seenStatusColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            child: Text(name[0]),
          ),
          Container(
            //  width: 270,
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Icon(
                      seenStatus,
                      color: seenStatusColor,
                    ),
                    Text(mostRecentMessage),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            child: Text(
              seenDate,
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
