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
    "İbrahim Uğurlu",
    "Özüm Düvenci"
  ];

  List<String> messageList = [
    "Merhaba, nasılsın?",
    "Dolar yükselmeye devam eder.",
    "Yarın kahve içelim mi?",
    "Amasya'yı çok seviyorum!",
    "Mavi rengini sevmem.",
  ];

  List<String> seenDateList = [
    "13:15",
    "09:55",
    "Yesterday",
    "Yesterday",
    "25.11.2021",
  ];

  List<IconData> seenStatusList = [
    Icons.done,
    Icons.done_all,
    Icons.done,
    Icons.done_all,
    Icons.done_all,
  ];

  List<Color> seenStatusColorList = [
    Colors.grey,
    Colors.blue.shade300,
    Colors.grey,
    Colors.blue.shade300,
    Colors.blue.shade300,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Satir(
          name: nameList[index],
          mostRecentMessage: messageList[index],
          seenDate: seenDateList[index],
          seenStatus: seenStatusList[index],
          seenStatusColor: seenStatusColorList[index],
        );
      },
      itemCount: nameList.length,
      padding: EdgeInsets.all(8),
    );
  }
}
