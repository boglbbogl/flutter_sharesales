import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sharesales/salesmanagement/salesdata.dart';

import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:sharesales/salesmanagement/salesfirestore.dart';


DateTime selectedTime = DateTime.now();
//
class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  SalesFirestore fireserv = SalesFirestore();


  @override
  Widget build(BuildContext context) {
    String _totalsales;
    int _actualsales;

    var inputDate = DateFormat('EEE, d MMM yy').format(selectedTime);

    final inputSizeHeight = MediaQuery.of(context).size.height * 0.1;
    final inputSizeWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: IconButton(
                icon: Icon(Icons.save),
                iconSize: 30,
                color: Colors.pinkAccent,
                onPressed: () async {
                  SalesData salesdata = await SalesData(_totalsales, _actualsales);
                  fireserv.addData(salesdata);
                  print("save!!");
                  Navigator.pop(context);
                }),
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
                        initialDate: selectedTime,
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
                          selectedTime = dateTime;
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: inputSizeHeight,
                  width: inputSizeWidth,
                  child: TextFormField(
                      decoration: InputDecoration(labelText: '총매출'),
                      onChanged: (val) {
                        _totalsales = (val);
                      },
                    keyboardType: TextInputType.number,
                    inputFormatters: [ThousandsFormatter()],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: inputSizeHeight,
                  width: inputSizeWidth,
                  child: TextFormField(
                      decoration: InputDecoration(labelText: '실매출'),
                      onChanged: (val) {
                        _actualsales = int.parse(val);
                      },
                    keyboardType: TextInputType.number,
                    // inputFormatters: [ThousandsFormatter()],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


