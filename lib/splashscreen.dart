import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  @override
  void initState() {
    super.initState();
    initializeUser();
    navigateUser();
  }

  Future initializeUser() async {
    await Firebase.initializeApp();
    final User firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser.reload();
    _user = await _auth.currentUser;
    // get User authentication status here
  }

  navigateUser() async {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null) {
      // &&  FirebaseAuth.instance.currentUser.reload() != null
      Timer(
        Duration(),
            () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(username: _auth.currentUser.displayName)),
                (Route<dynamic> route) => false),
      );
    } else {
      Timer(Duration(),
              () => Navigator.pushReplacementNamed(context, "/auth"));
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      ),
    );
  }
}