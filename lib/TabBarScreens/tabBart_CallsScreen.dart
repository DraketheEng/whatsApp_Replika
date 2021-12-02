import 'package:flutter/material.dart';
import 'package:whatsapp_replika/models/CallModel.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({Key? key}) : super(key: key);

  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return CallModel(
              name: callNamesList[index],
              callDate: callDatesList[index],
              callType: callTypeList[index],
              answerStatus: answerStatusList[index],
              answerStatusColor: answerStatusColorList[index],
            );
          },
          itemCount: callNamesList.length,
        ),
      ),
    );
  }
}

List<String> callNamesList = [
  "Kaan Kaval",
  "Zahid Uğurlu",
  "Furkan Aydemir",
  "Akif Uğurlu",
  "Nazif Göymen",
];

List<String> callDatesList = [
  "Today, 8:15 in the evening",
  "25 November, 6:45 in the morning",
  "1 December, 9:15 in the evening",
  "3 months ago",
  "4 months ago",
];

List<IconData> answerStatusList = [
  Icons.call_made,
  Icons.call_missed,
  Icons.call_missed_outgoing,
  Icons.call_received,
  Icons.call_made,
];

List<IconData> callTypeList = [
  Icons.videocam,
  Icons.call,
  Icons.call,
  Icons.call,
  Icons.videocam,
];

List<Color> answerStatusColorList = [
  Color(0xff25D366),
  Colors.red,
  Colors.red,
  Color(0xff25D366),
  Color(0xff25D366),
];
