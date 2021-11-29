import 'package:flutter/material.dart';
import 'package:whatsapp_replika/models/ChatModel.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<String> nameList = [
    "Nazif Göymen",
    "Cem İşeri",
    "Onur Şimşek",
    "Özüm Düvenci"
  ];

  List<String> messageList = [
    "Merhaba, nasılsın?",
    "Dolar yükselmeye devam eder.",
    "Yarın kahve içelim mi?",
    "Mavi rengini hiçbir zaman sevmedim.",
  ];

  List<String> seenDateList = [
    "13:15",
    "09:55",
    "Yesterday",
    "25.11.2021",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Satir(
          name: nameList[index],
          mostRecentMessage: messageList[index],
          seenDate: seenDateList[index],
        );
      },
      itemCount: nameList.length,
      padding: EdgeInsets.all(8),
    );
  }
}
