import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';


class SalesAddPage extends StatefulWidget {
  @override
  _SalesAddPageState createState() => _SalesAddPageState();
}

class _SalesAddPageState extends State<SalesAddPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedTime = DateTime.now();

  TextEditingController totalsales = TextEditingController();
  TextEditingController actualsales = TextEditingController();

  // @override
  // void dispose(){
  //   totalsales.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final inputSizeHeight = MediaQuery.of(context).size.height * 0.1;
    final inputSizeWidth = MediaQuery.of(context).size.width * 0.4;

    final moneyInputFormatter = MoneyInputFormatter(
      useSymbolPadding: false,
      mantissaLength: 0,
    );

    var inputDate = DateFormat('EEE, d MMM yy').format(_selectedTime);
    var dbWritingDate = DateFormat('yyyy MM dd EEE').format(_selectedTime);

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 30),
              child: IconButton(
                icon: Icon(Icons.check),
                iconSize: 30,
                color: Colors.pinkAccent,
                onPressed: () async {
                  await firestore
                      .collection('Sales')
                      .doc('$dbWritingDate')
                      .set({
                    'TotalSales': totalsales.text,
                    // 'date': _selectedTime.microsecondsSinceEpoch,
                    'ActualSales': actualsales.text,
                    // 'VOS' : vos,
                    // 'VAT' : vat,
                    // 'Discount' : discount,
                    // 'Delivery' : delivery,
                    // 'Card' : card,
                    // 'Vocher' : vocher,
                    // 'Cash' : cash,
                    // 'CashReceipt' : cashreceipt,
                  });
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print("save");
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: IconButton(
                icon: Icon(Icons.backspace_outlined),
                color: Colors.pinkAccent,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: inputSizeHeight,
                      width: inputSizeWidth,
                      child: Text(
                        inputDate,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: inputSizeHeight,
                      width: inputSizeWidth,
                      child: InkWell(
                        onTap: () async {
                          Future<DateTime> selectedDate = showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.dark(),
                                child: child,
                              );
                            },
                          );
                          selectedDate.then((dateTime) {
                            setState(() {
                              _selectedTime = dateTime;
                            });
                          });
                        },
                        child: Text(
                          "Select Date",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    height: inputSizeHeight,
                    width: inputSizeWidth,
                    child: TextFormField(
                      controller: totalsales,
                      // onChanged: (value) => {totalsales = value},
                      // onChanged: (value) {totalsales = value;},
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Enter some text';
                      //   } else
                      //     return null;
                      // },
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        // hintText: '총 매출',
                        labelText: '총매출',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [moneyInputFormatter],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: inputSizeHeight,
                    width: inputSizeWidth,
                    child: TextFormField(
                      controller: actualsales,
                      // onChanged: (value) {actualsales = value;},
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Enter some text';
                      //   } else
                      //     return null;
                      // },
                      decoration: InputDecoration(
                        labelText: '실매출',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [moneyInputFormatter],
                    ),
                  ),
                ],
              ),
              // Column(
              //   children: <Widget>[
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (text) => vos = text,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: '공급가액',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (text) => vat = text,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: 'VAT포함',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // Column(
              //   children: <Widget>[
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (text) => discount = text,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: '할인',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (text) => delivery = text,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: '배달',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // Column(
              //   children: <Widget>[
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (text) => card = text,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: '신용카드',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (text) => vocher = text,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: '상품권',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // Column(
              //   children: <Widget>[
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (int) => cash = int,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: '현금',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: inputSizeHeight,
              //           width: inputSizeWidth,
              //           child: TextFormField(
              //             onChanged: (int) => cashreceipt = int,
              //             // validator: (value) {
              //             //   if (value.isEmpty) {
              //             //     return 'Enter some text';
              //             //   } else
              //             //     return null;
              //             // },
              //             decoration: InputDecoration(
              //               labelText: '현금영수증',
              //             ),
              //             keyboardType: TextInputType.number,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


class SalesRegistrationPage extends StatefulWidget {
  @override
  _SalesRegistrationPageState createState() => _SalesRegistrationPageState();
}

class _SalesRegistrationPageState extends State<SalesRegistrationPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: salesListView(),
      // body: Center(
      //   child: Column(
      //     children: <Widget>[
      //       Container(
      //         height: MediaQuery.of(context).size.height * 0.20,
      //         width: MediaQuery.of(context).size.width * 0.9,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(27),
      //             gradient: LinearGradient(
      //                 end: Alignment.bottomCenter,
      //                 begin: Alignment.center,
      //                 colors: <Color>[Colors.white, Colors.purple])),
      //         child: Card(
      //           elevation: 40,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           child: Stack(
      //             children: <Widget>[
      //               Positioned(
      //                 child: Text(
      //                   '총매출 : 3,000,000',
      //                   style: TextStyle(color: Colors.black),
      //                 ),
      //                 top: 20,
      //               ),
      //               Positioned(
      //                 child: Text(
      //                   '공급가액 : 2,700,000',
      //                   style: TextStyle(color: Colors.black),
      //                 ),
      //                 top: 40,
      //               ),
      //               Positioned(
      //                 child: Text(
      //                   '할인 : 1,000',
      //                   style: TextStyle(color: Colors.black),
      //                 ),
      //                 top: 60,
      //               ),
      //               Positioned(
      //                 child: Text(
      //                   '실매출 : 2,800,000',
      //                   style: TextStyle(color: Colors.black),
      //                 ),
      //                 top: 80,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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