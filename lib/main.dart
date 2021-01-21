import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharesales/authscreen.dart';
import 'package:sharesales/splashscreen.dart';

var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Share Sales !!',
    theme: ThemeData(
        primarySwatch: Colors.pink
    ),
    routes: routes,
    home: SplashScreen(),
  ));
}

