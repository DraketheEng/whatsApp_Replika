import 'package:flutter/material.dart';

class StatusModel extends StatelessWidget {
  String name;
  String postDate;
  StatusModel({Key? key, required this.name, required this.postDate})
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
              Text(postDate),
            ],
          ),
        ),
      ],
    );
  }
}
