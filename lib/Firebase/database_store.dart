import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseDA {
  static Future<List<Map<String, dynamic>>> getColData(String collection) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    QuerySnapshot snapshot = await collectionReference.get();
    List<Map<String, dynamic>> listData = [];
    for (var element in snapshot.docs) {
      var result = await collectionReference.doc(element.id).get();
      Map<String, dynamic> jsonObj = jsonDecode(jsonEncode(result.data()));
      jsonObj['ID'] = element.id;
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
    await collectionReference.doc(docId).set(jsonDecode(jsonEncode(data)));
  }

  static Future<void> delete(String collection, String docId) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    await collectionReference.doc(docId).delete();
  }

  static Future<List<String>> getFiles(String? folder) async {
    final Reference ref = FirebaseStorage.instance.ref(folder);
    try {
      List<String> listPath = [];
      ListResult listResult = await ref.listAll();
      for (var e in listResult.items) {
        String path = await e.getDownloadURL();
        listPath.add(path);
      }
      return listPath;
    } catch (e) {
      return [];
    }
  }

  static Future<int> putFile(String filePath, {String? folder}) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref().child('${folder!}/${filePath.split("/").last}');
      await ref.putFile(File(filePath));
      return 200;
    } catch (e) {
      return 404;
    }
  }

  static Future<int> deleteFile(String? fileName) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref(fileName);
      await ref.delete();
      return 200;
    } catch (e) {
      return 404;
    }
  }
}
