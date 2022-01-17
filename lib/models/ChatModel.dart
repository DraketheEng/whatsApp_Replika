import 'package:flutter/material.dart';
import 'package:whatsapp_replika/view/PrivateChat/PrivateChatScreen.dart';

late final ChatLine chatLine;

class ChatLine extends StatelessWidget {
  String contactName;
  String mostRecentMessage;
  String seenDate;

  ChatLine({
    Key? key,
    required this.contactName,
    required this.mostRecentMessage,
    required this.seenDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: CircleAvatar(
              child: Text(contactName[0]),
            ),
          ),
          Container(
            //  width: 270,
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
                Row(
                  children: [
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
