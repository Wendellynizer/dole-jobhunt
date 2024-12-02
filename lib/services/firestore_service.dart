import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/job.dart';

class FireStoreService {

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // creates entry in the db
  static create(String doc, Map<String, dynamic> data) async {
    _db.collection(doc).add(data).whenComplete(() {
      print("doc added");
    });
  }

  // get all entries in the db
  // static Future<CollectionReference<Map<String, dynamic>>> read(String doc) async {
  //     return _db.collection(doc);
  // }

  // static Future<List<dynamic>> getAll(String doc) async {
  //   final snapshot = await _db.collection(doc).get();
  //
  // }
}