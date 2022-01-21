import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var snackBar = SnackBar(content: Text('Registered successfully'));
  bool _isObscure = true;

  showPassword() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> signUpButton() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((user) {
      FirebaseFirestore.instance.collection("Users").doc(user.user!.uid).set({
        "username": userNameController.text,
        "email": emailController.text
      }).whenComplete(() => Navigator.push(
          context, MaterialPageRoute(builder: (_) => LoginScreen())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WhatsApp Replika"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff075E54))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff075E54))),
                      border: OutlineInputBorder(),
                      labelText: 'Your Full Name',
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon:
                          Icon(Icons.person_outline, color: Color(0xff075E54))),
                ),
              ),
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
                      labelText: 'E-mail Adress',
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon:
                          Icon(Icons.mail_outline, color: Color(0xff075E54))),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: _isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff075E54))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff075E54))),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
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
              SizedBox(height: 20),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff075E54))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                    onPressed: () async {
                      await signUpButton().whenComplete(() =>
                          ScaffoldMessenger.of(context).showSnackBar(snackBar));
                    },
                  )),
            ],
          ),
        ));
  }
}
