import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharesales/salesmanagement/salesdata.dart';
import 'package:sharesales/salesmanagement/salesfirestore.dart';
import 'package:sharesales/salesmanagement/salespage.dart';

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
      list = querySnapshot.docs
          .map((documentSnapshot) => SalesData(
                documentSnapshot.data()['totalsales'],
                documentSnapshot.data()['actualsales'],
              ))
          .toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputSizeHeight = MediaQuery.of(context).size.height * 0.05;
    final inputSizeWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      body: _salesList(),
      // body: ListView.builder(
      //       itemCount: list.length,
      //       itemBuilder: (context, index){
      //         return SingleChildScrollView(
      //           child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //             children: <Widget>[
      //               Container(
      //                   alignment: Alignment.center,
      //                   height: inputSizeHeight,
      //                   width: inputSizeWidth,
      //                   child: Text(list[index].totalsales.toString())),
      //               Container(
      //                   alignment: Alignment.center,
      //                   height: inputSizeHeight,
      //                   width: inputSizeWidth,
      //                   child: Text(list[index].actualsales.toString())),
      //             ],
      //           ),
      //         );
      //       },
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SalesPage(),
              ));
        },
      ),
    );
  }

  Widget _salesList() {
    return Scaffold(
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: InkWell(
                onTap: (){
                  print("click");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.15,
                        width: MediaQuery.of(context).size.width*0.9,
                        child: Stack(
                          children: <Widget>[
                            Text('$selectedTime'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Text(list[index].totalsales.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Text(list[index].actualsales.toString()),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text("지출"),
                                    ),
                                    Container(
                                      child: Text("지출2"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
