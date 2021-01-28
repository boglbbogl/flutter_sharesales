import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharesales/sales_add_page.dart';

class SalesRegistrationPage extends StatefulWidget {
  @override
  _SalesRegistrationPageState createState() => _SalesRegistrationPageState();
}

class _SalesRegistrationPageState extends State<SalesRegistrationPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: salesListView(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.center,
                      colors: <Color>[Colors.white, Colors.purple])),
              child: Card(
                elevation: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(
                        '총매출 : 3,000,000',
                        style: TextStyle(color: Colors.black),
                      ),
                      top: 20,
                    ),
                    Positioned(
                      child: Text(
                        '공급가액 : 2,700,000',
                        style: TextStyle(color: Colors.black),
                      ),
                      top: 40,
                    ),
                    Positioned(
                      child: Text(
                        '할인 : 1,000',
                        style: TextStyle(color: Colors.black),
                      ),
                      top: 60,
                    ),
                    Positioned(
                      child: Text(
                        '실매출 : 2,800,000',
                        style: TextStyle(color: Colors.black),
                      ),
                      top: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SalesAddPage()),
            ),
      ),
    );
  }

  Widget salesListView() {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('Sales').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.documents.map((document) {
              return Center(
                child: Container(
                  child: Text("Title:" + document['title']),
                ),
              );
            }).toList(),
          );
        }
    );
  }
}
