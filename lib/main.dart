import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {
  var title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: () async{
            await Firestore.instance.collection('Sales').add({'title':title, 'subtitle':subtitle});
            Navigator.pop(context);
          })
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (text) => title = text,
          ),
          TextFormField(
            onChanged: (text) => subtitle = text,
          ),
        ],
      ),
    );
  }
}
