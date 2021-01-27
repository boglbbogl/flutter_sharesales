import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharesales/salesmanagement/salesdata.dart';
import 'package:sharesales/salesmanagement/salesfirestore.dart';

class SalesMainPage extends StatefulWidget {
  @override
  _SalesMainPageState createState() => _SalesMainPageState();
}

class _SalesMainPageState extends State<SalesMainPage> {
  StreamSubscription<QuerySnapshot> inputTasks;
  List<SalesData> list;
  SalesFirestore firesev = SalesFirestore();

  @override
  void initState() {
    super.initState();

    list = List();
    inputTasks?.cancel();
    inputTasks = firesev.getDocumments().listen((QuerySnapshot querySnapshot) {
      list = querySnapshot.docs.map((documentSnapshot) =>
          SalesData(
            documentSnapshot.data()['totalsales'],
            documentSnapshot.data()['actualsales'],
          )).toList();
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(list[index].totalsales.toString()),
              );
            },
        ),
    );
  }
}
