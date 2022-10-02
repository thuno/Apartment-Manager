import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseDA {
  static Future<List<Map<String, dynamic>>> getColData(String collection) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    QuerySnapshot snapshot = await collectionReference.get();
    List<Map<String, dynamic>> listData = [];
    for (var element in snapshot.docs) {
      var result = await collectionReference.doc(element.id).get();
      Map<String, dynamic> jsonObj = jsonDecode(jsonEncode(result.data()));
      listData.add(jsonObj);
    }
    return listData;
  }

  static Future<Map<String, dynamic>> getDocData(String collection, String docID) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection(collection).doc(docID).get();
    return jsonDecode(jsonEncode(docSnapshot.data()));
  }

  static Future<String> add(String collection, Map<String, dynamic> data) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    DocumentReference newDoc = await collectionReference.add(data);
    String newId = newDoc.id;
    return newId;
  }

  static Future<void> edit(String collection, String docId, Map<String, dynamic> data) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    await collectionReference.doc(docId).set(jsonEncode(data));
  }

  static Future<void> delete(String collection, String docId) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    await collectionReference.doc(docId).delete();
  }
}
