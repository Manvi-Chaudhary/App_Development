import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practiceauthverifi/datamodel.dart';
import 'package:practiceauthverifi/usermodel.dart';

class DatabaseService {
  String? uid, did;
  DatabaseService({this.uid, this.did});

  final CollectionReference record =
      FirebaseFirestore.instance.collection("Record");

  Future field(String name, int amount, bool give) async {
    return await record.doc(uid).collection("Transanctions").doc(did).set({
      'Name': name,
      'Amount': amount,
      'Give': give,
      'Date': DateTime.now(),
    });
  }

  Future deleteform(id) async {
    try {
      record.doc(uid).collection("Transanctions").doc(id).delete();
      /*final docuser = record.doc(uid).collection("Transanctions").doc(id);
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        await myTransaction.delete(docuser);
      });*/
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //datamodel function for converting query snapdhot into our custom data model
  List<Datamodel> _listdatafromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Datamodel(
              amount: doc.get('Amount') ?? 0,
              give: doc.get('Give') ?? false,
              name: doc.get('Name') ?? 'Person',
              doc_id: doc.id,
              date: DateTime.fromMicrosecondsSinceEpoch(
                  doc.get('Date').microsecondsSinceEpoch),
            ))
        .toList();
  }

  //stream setup
  Stream<List<Datamodel>> get data {
    return record
        .doc(uid)
        .collection("Transanctions")
        .orderBy('Date', descending: true)
        .snapshots()
        .map(_listdatafromsnapshot);
  }
}
