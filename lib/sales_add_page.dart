import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharesales/salesregistrationpage.dart';



class SalesAddPage extends StatefulWidget {

  @override
  _SalesAddPageState createState() => _SalesAddPageState();
}

class _SalesAddPageState extends State<SalesAddPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                onPressed: () async{
                  // await FirebaseFirestore.instance.collection('abc').add({'abc': title});
                  // .add({'ActualSalesTotal': _ActualSalesTotal},);
                  // if (!_formKey.currentState.validate()) {
                  //   return;
                  // }
                  // _formKey.currentState.save();
                  // print("save");
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
