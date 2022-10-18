import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// class khai báo các hàm xử lý dữ liệu cung từ firebase
class FireBaseDA {
  // function lấy ra thông tin các document nàm trong collection tương ứng
  static Future<List<Map<String, dynamic>>> getColData(String collection) async {
    // khai báo biến hứng dữ liệu tương úng vs tên collection
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    // lấy dữ liệu của collection này
    QuerySnapshot snapshot = await collectionReference.get();
    List<Map<String, dynamic>> listData = [];
    for (var element in snapshot.docs) {
      var result = await collectionReference.doc(element.id).get();
      Map<String, dynamic> jsonObj = jsonDecode(jsonEncode(result.data()));
      if (jsonObj['ID'] == null) {
        jsonObj['ID'] = element.id;
      }
      listData.add(jsonObj);
    }
    return listData;
  }

  // function xóa toàn bộ thông tin của collection vs tên tương úng
  static Future<void> deleteCol(String collection) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    QuerySnapshot snapshot = await collectionReference.get();
    for (var element in snapshot.docs) {
      await delete(collection, element.id);
    }
  }

  // function lấy ra dữ liệu của document
  static Future<Map<String, dynamic>> getDocData(String collection, String docID) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection(collection).doc(docID).get();
    return jsonDecode(jsonEncode(docSnapshot.data()));
  }

  // function thêm document vào collection nếu collection này chua tồn tại thì tự động tạo rồi lưu document mói
  static Future<String> add(String collection, Map<String, dynamic> data) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    DocumentReference newDoc = await collectionReference.add(data);
    String newId = newDoc.id;
    return newId;
  }

  // sửa dữ liệu của document
  static Future<void> edit(String collection, String docId, Map<String, dynamic> data) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    await collectionReference.doc(docId).set(jsonDecode(jsonEncode(data)));
  }

  // xóa document khỏi collection
  static Future<void> delete(String collection, String docId) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(collection);
    await collectionReference.doc(docId).delete();
  }

  // lấy link file
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

  // lưu file vào firebase storage
  static Future<int> putFile(String filePath, {String? folder}) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref().child('${folder!}/${filePath.split("/").last}');
      await ref.putFile(File(filePath));
      return 200;
    } catch (e) {
      return 404;
    }
  }

  // xóa file khỏi firebase storage
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
