import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dataservice {
  String uid = "";
  Dataservice({required this.uid});

  CollectionReference record = FirebaseFirestore.instance.collection("data");

  Future cred(String email, String username, String password) async {
    return await record
        .doc(uid)
        .set({"Email": email, "Username": username, "Password": password});
  }

  Future wishlist(
      String productID, String image, String name, int price) async {
    return await record.doc(uid).collection("Wishlist").doc().set({
      "ProductID": productID,
      "Image": image,
      "Name": name,
      "Price": price,
    });
  }

  Future removewish(id) async {
    return await record.doc(uid).collection("Wishlist").doc(id).delete();
  }

  Future<String> isAlreadyPresent(String productID) async {
    QuerySnapshot s = await record
        .doc(uid)
        .collection("Wishlist")
        .where("ProductId", isEqualTo: productID)
        .get();
    if (s.docs.isEmpty) {
      return "NO";
    } else {
      return "YES";
    }
  }

  Stream<QuerySnapshot> get wish {
    return record.doc(uid).collection("Wishlist").snapshots();
  }

  Future<String?> getemail(String username, String password) async {
    QuerySnapshot s = await record
        .where("Username", isEqualTo: username)
        .where("Password", isEqualTo: password)
        .get();
    if (s.docs == []) {
      return null;
    }
    return s.docs[0]["Email"];
  }
}
