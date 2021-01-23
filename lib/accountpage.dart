import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authscreen.dart';

class accountPage extends StatefulWidget {
  @override
  _accountPageState createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black54,
              size: 30,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await googleSignIn.disconnect();
              await googleSignIn.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                      (Route<dynamic> route) => false);
            },
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => {},
              color: Colors.black54,
              iconSize: 30,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.purple, Colors.pink]),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(
                        _auth.currentUser.displayName,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      right: 40,
                      bottom: 50,
                    ),
                    Positioned(
                      child: Text(
                        _auth.currentUser.email,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      right: 40,
                      bottom: 30,
                    ),
                    Positioned(
                      child: Text(
                        "돈까스상회",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      right: 40,
                      bottom: 100,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(300, 6, 90, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230),
              child: Container(
                width: 100,
                child: Container(
                  child: RaisedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      await googleSignIn.disconnect();
                      await googleSignIn.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => AuthScreen()),
                              (Route<dynamic> route) => false);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                    padding: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Text(
                      "Log out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
