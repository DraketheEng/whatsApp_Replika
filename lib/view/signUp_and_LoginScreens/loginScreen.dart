import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_replika/view/signUp_and_LoginScreens/googleSignIn.dart';

import '../../main.dart';
import 'resetPasswordScreen.dart';
import 'signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isChecked = false;

  bool _isObscure = true;

  showPassword() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> signInButton() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((user) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Iskele()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp Replika'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
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
                        labelText: 'E-Mail Adress',
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 20.0,
                  child: Row(
                    children: <Widget>[
                      Theme(
                        data:
                            ThemeData(unselectedWidgetColor: Color(0xff075E54)),
                        child: Checkbox(
                          value: _isChecked,
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                      ),
                      Text('Remember me'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PasswordResetScreen()));
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff075E54),
                        decoration: TextDecoration.underline),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff075E54))),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await signInButton();
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
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
                            CircleAvatar(
                                backgroundColor: Color(0xff075E54),
                                radius: 15,
                                child: Image.asset(
                                  'assets/images/google.jpg',
                                  fit: BoxFit.fill,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                      onPressed: () async {
                        await signInWithGoogle().then((user) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Iskele()),
                              (Route<dynamic> route) => false);
                        });
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      "Don't have account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      child: Text(
                        'Register now!',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff075E54),
                            decoration: TextDecoration.underline),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUp()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
              ],
            )));
  }
}
