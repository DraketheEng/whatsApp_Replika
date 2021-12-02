import 'package:flutter/material.dart';

class PrivateChatScreen extends StatefulWidget {
  const PrivateChatScreen({Key? key}) : super(key: key);

  @override
  _PrivateChatScreenState createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  TextEditingController t1 = TextEditingController();
  List<MesajBalonu> mesajListesi = [];

  listeyeEkle(String gonderilenMesaj) {
    setState(() {
      MesajBalonu mesajlar = MesajBalonu(mesaj: gonderilenMesaj);
      mesajListesi.insert(0, mesajlar);
      t1.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                child: Text("N"),
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nazif Göymen",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Online",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem(child: Text('View Contact')),
              const PopupMenuItem(child: Text('Media, links, and docs')),
              const PopupMenuItem(child: Text('WhatsApp Web')),
              const PopupMenuItem(child: Text('Search')),
              const PopupMenuItem(child: Text('Mute Notification')),
              const PopupMenuItem(child: Text('Wallpaper')),
            ];
          })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, int index) {
                  return mesajListesi[index];
                },
                itemCount: mesajListesi.length,
                reverse: true,
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Card(
                        margin: EdgeInsets.only(bottom: 8, left: 2, right: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextFormField(
                          controller: t1,
                          onFieldSubmitted: listeyeEkle,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.emoji_emotions,
                                color: Color(0xff075E54),
                              ),
                              onPressed: () {},
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    return listeyeEkle(t1.text);
                                  },
                                  icon: Icon(Icons.send,
                                      color: Color(0xff075E54)),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return bottomSheet();
                                        });
                                  },
                                  icon: Icon(Icons.attach_file,
                                      color: Color(0xff075E54)),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8, left: 2, right: 2),
                      child: CircleAvatar(
                        backgroundColor: Color(0xff25D366),
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MesajBalonu extends StatelessWidget {
  var mesaj;

  MesajBalonu({required this.mesaj});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 100),
        child: Container(
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      mesaj,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("13:15"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.done_all,
                        color: Colors.blue.shade300,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomSheet() {
  return Container(
    height: 275,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomSheetItems(
                bottomSheetItemIcon: Icons.insert_drive_file_sharp,
                bottomSheetItemText: "Document",
                bottomSheetItemColor: Colors.indigo,
              ),
              BottomSheetItems(
                bottomSheetItemIcon: Icons.camera_alt,
                bottomSheetItemText: "Camera",
                bottomSheetItemColor: Colors.pink,
              ),
              BottomSheetItems(
                bottomSheetItemIcon: Icons.insert_photo,
                bottomSheetItemText: "Gallery",
                bottomSheetItemColor: Colors.purple,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomSheetItems(
                bottomSheetItemIcon: Icons.headset,
                bottomSheetItemText: "Audio",
                bottomSheetItemColor: Colors.orange,
              ),
              BottomSheetItems(
                bottomSheetItemIcon: Icons.location_pin,
                bottomSheetItemText: "Location",
                bottomSheetItemColor: Colors.pink,
              ),
              BottomSheetItems(
                bottomSheetItemIcon: Icons.person,
                bottomSheetItemText: "Contact",
                bottomSheetItemColor: Colors.blue,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

class BottomSheetItems extends StatelessWidget {
  BottomSheetItems(
      {Key? key,
      required this.bottomSheetItemIcon,
      required this.bottomSheetItemText,
      required this.bottomSheetItemColor})
      : super(key: key);

  IconData bottomSheetItemIcon;
  String bottomSheetItemText;
  Color bottomSheetItemColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(18),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: bottomSheetItemColor,
              radius: 30,
              child: Icon(bottomSheetItemIcon),
            ),
            Text(bottomSheetItemText)
          ],
        ),
      ),
    );
  }
}
