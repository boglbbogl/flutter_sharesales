import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sharesales/salesregistrationpage.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class CustomPicker extends CommonPickerModel{

  String digits(int value, int length){
    return '$value'.padLeft(length,"0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale}) : super(locale: locale){
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
  }
  @override
  String leftStringAtIndex(int index){
    if (index >= 0 && index < 24){
      return this.digits(index, 2);
    } else {
      return null;
    }
  }
}

class SalesAddPage extends StatefulWidget {

  @override
  _SalesAddPageState createState() => _SalesAddPageState();
}

class _SalesAddPageState extends State<SalesAddPage> {

  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDateTime = DateTime.now();


  @override
  Widget build(BuildContext context) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var title;

    DateTime selectedDateTime;
    bool pressed = false;

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
                  await firestore.collection('Sales').document('sales').setData(
                      {'date': DateTime
                          .now()
                          .microsecondsSinceEpoch, 'title': title});
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
                onPressed: () =>
                    Navigator.pop(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        pressed = true;

                        DatePicker.showDatePicker(context, showTitleActions: true,
                        onChanged: (date){
                          print('change $date in time zone' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date){
                          selectedDateTime = date;
                          print('confirm $date');
                            }, currentTime: DateTime(2000, 12, 31, 23, 12, 34));
                      });
                    },
                    child: Text(
                      'Selete Date Time ',style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  // SizedBox(height: 50,),
                  // pressed ? _displayDateTime(selectedDateTime): SizedBox(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
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
  Widget _displayDateTime(selectedDateTime){
    return Center(
      child: Text("selected $selectedDateTime", style: TextStyle(fontSize: 15),),
    );
  }
}

