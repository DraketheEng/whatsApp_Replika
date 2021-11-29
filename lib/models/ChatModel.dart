import 'package:flutter/material.dart';

class Satir extends StatelessWidget {
  String name;
  String mostRecentMessage;
  String seenDate;

  Satir(
      {Key? key,
      required this.name,
      required this.mostRecentMessage,
      required this.seenDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(name[0]),
        ),
        Container(
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
              Text(mostRecentMessage),
            ],
          ),
        ),
        Container(
          child: Text(
            seenDate,
            style: TextStyle(fontSize: 10),
          ),
        )
      ],
    );
  }
}
