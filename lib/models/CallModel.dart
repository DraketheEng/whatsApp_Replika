import 'package:flutter/material.dart';

class CallModel extends StatelessWidget {
  String name;
  String callDate;
  IconData answerStatus, callType;

  CallModel(
      {Key? key,
      required this.name,
      required this.callDate,
      required this.answerStatus,
      required this.callType})
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
              Row(
                children: [
                  Icon(
                    answerStatus,
                    color: Color(0xff25D366),
                  ),
                  Text(callDate),
                  Icon(
                    callType,
                    color: Color(0xff25D366),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
