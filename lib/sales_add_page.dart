import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharesales/salesregistrationpage.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';


class SalesAddPage extends StatefulWidget {
  @override
  _SalesAddPageState createState() => _SalesAddPageState();
}

class _SalesAddPageState extends State<SalesAddPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedTime ;
  // final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var inputDate = DateFormat('E MMM dd yy').format(_selectedTime);

    var title;

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
                      .document('$_selectedTime')
                      .setData({
                    'date': title,
                    // 'date': _selectedTime.microsecondsSinceEpoch,
                    'title': title,

                  });
                  // .add({'ActualSalesTotal': _ActualSalesTotal},);
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print("save");
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: IconButton(
                icon: Icon(Icons.backspace_outlined),
                color: Colors.pinkAccent,
                onPressed: () => Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesRegistrationPage()),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.4,
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
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InkWell(
                      onTap: () {
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
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    onChanged: (text) => title = text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter some text';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      hintText: 'ex) 1,000,000',
                      labelText: '총 매출',
                    ),
                  ),
                ),
                // Container(
                //   alignment: Alignment.topCenter,
                //   height: MediaQuery
                //       .of(context)
                //       .size
                //       .height * 0.1,
                //   width: MediaQuery
                //       .of(context)
                //       .size
                //       .width * 0.4,
                //   child: TextFormField(
                //     validator: (value) {
                //       if (value.isEmpty) {
                //         return 'Enter some text';
                //       } else
                //         return null;
                //     },
                //     decoration: InputDecoration(
                //       // border: InputBorder.none,
                //       hintText: 'ex)800,000',
                //       labelText: '실매출',
                //     ),
                //   ),
                // ),
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
            //           height: MediaQuery
            //               .of(context)
            //               .size
            //               .height * 0.1,
            //           width: MediaQuery
            //               .of(context)
            //               .size
            //               .width * 0.4,
            //           child: TextFormField(
            //             validator: (value) {
            //               if (value.isEmpty) {
            //                 return 'Enter some text';
            //               } else
            //                 return null;
            //             },
            //             decoration: InputDecoration(
            //               // border: InputBorder.none,
            //               hintText: 'ex) 999,000',
            //               labelText: '공급가액',
            //             ),
            //           ),
            //         ),
            //         Container(
            //           alignment: Alignment.topCenter,
            //           height: MediaQuery
            //               .of(context)
            //               .size
            //               .height * 0.1,
            //           width: MediaQuery
            //               .of(context)
            //               .size
            //               .width * 0.4,
            //           child: TextFormField(
            //             validator: (value) {
            //               if (value.isEmpty) {
            //                 return 'Enter some text';
            //               } else
            //                 return null;
            //             },
            //             decoration: InputDecoration(
            //               // border: InputBorder.none,
            //               hintText: 'ex) 40,000',
            //               labelText: '할인',
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
