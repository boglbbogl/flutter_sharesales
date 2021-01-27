import 'package:flutter/material.dart';
import 'package:sharesales/salesmanagement/salesdata.dart';
import 'package:sharesales/salesmanagement/salesfirestore.dart';
import 'package:sharesales/salesmanagement/salesmainpage.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  SalesFirestore fireserv = SalesFirestore();

  @override
  Widget build(BuildContext context) {
    int _totalsales;
    int _actualsales;

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Totalsales'
            ),
            keyboardType: TextInputType.number,
            onChanged: (val){
              _totalsales = int.parse(val);
            },
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Actualsales'
            ),
            keyboardType: TextInputType.number,
            onChanged: (val){
              _actualsales = int.parse(val);
            },
          ),
          RaisedButton(onPressed: (){
            SalesData salesdata = SalesData(_totalsales, _actualsales);
            fireserv.addData(salesdata);
            print("save!!");
          },
          child: Text("submit"),
          ),
          RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SalesMainPage()));
          },
            child: Text("Back"),
          )
        ],
      ),
    );
  }
}
