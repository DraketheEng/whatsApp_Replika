import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  var mySnackBar = SnackBar(content: Text('Password changed successfully'));

  bool _isObscure = true;

  showPassword() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> resetPassword() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(emailController.text)
        .update({'User Password': newPasswordController.text}).whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(mySnackBar));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp Replika"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Reset your password',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff075E54))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff075E54))),
                  border: OutlineInputBorder(),
                  labelText: 'E-mail adress',
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon:
                      Icon(Icons.mail_outline, color: Color(0xff075E54))),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              obscureText: _isObscure,
              controller: newPasswordController,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff075E54))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff075E54))),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your new password',
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.lock_outline : Icons.lock_open,
                      color: Color(0xff075E54),
                    ),
                    onPressed: () {
                      showPassword();
                    },
                  )),
            ),
          ),
          SizedBox(height: 15),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff075E54))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Reset password',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
                onPressed: () async {
                  await resetPassword().whenComplete(() => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen())));
                },
              )),
        ]),
      ),
    );
  }
}
