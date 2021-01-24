import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class SalesAddPage extends StatefulWidget {
  @override
  _SalesAddPageState createState() => _SalesAddPageState();
}

class _SalesAddPageState extends State<SalesAddPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final inputSizeHeight = MediaQuery.of(context).size.height * 0.1;
    final inputSizeWidth = MediaQuery.of(context).size.width * 0.4;

    var inputDate = DateFormat('EEE, d MMM yy').format(_selectedTime);

    var totalsales, actualsales;
    // , vos, vat, discount, delivery, card, vocher, cash, cashreceipt;

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
                      .doc('$_selectedTime')
                      .set({
                    'TotalSales': int.parse(totalsales),
                    // 'date': _selectedTime.microsecondsSinceEpoch,
                    'ActualSales': int.parse(actualsales),
                    // 'VOS' : vos,
                    // 'VAT' : vat,
                    // 'Discount' : discount,
                    // 'Delivery' : delivery,
                    // 'Card' : card,
                    // 'Vocher' : vocher,
                    // 'Cash' : cash,
                    // 'CashReceipt' : cashreceipt,
                  });
                  // .add({'ActualSalesTotal': _ActualSalesTotal},);
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print("save");
                  // Navigator.pop(context);
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
                      onChanged: (value) {totalsales = value;},
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
                      // initialValue: '0',
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: inputSizeHeight,
                    width: inputSizeWidth,
                    child: TextFormField(
                      onChanged: (value) { actualsales = value;},
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
