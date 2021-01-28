
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sharesales/salesmanagement/salesdata.dart';
import 'package:sharesales/salesmanagement/salespage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SalesFirestore {
  final CollectionReference salescollection = firestore.collection('Sales');

  // Create
  Future addData(SalesData salesdata) async {
    TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(salescollection.doc('$selectedTime'));
      Map<String, dynamic> data = {
        'totalsales' : salesdata.totalsales,
        'actualsales' : salesdata.actualsales,
      };
      await tx.set(ds.reference, data);
    };

    return firestore.runTransaction(createTransaction).catchError((onError){
      print(onError);
      return null;
    });
  }

  Stream<QuerySnapshot> getDocumments(){
    Stream<QuerySnapshot> snapshots = salescollection.snapshots();
    return snapshots;
  }


  // Read

  // Update

  // Delete
}