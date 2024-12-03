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

  static Future<dynamic> get() async {

  }

  // get all data from specific doc
  static Future<List<dynamic>> getAll(String doc) async {

    final snapshot = await _db.collection(doc).get();

    List<dynamic> jobs = snapshot.docs.map((e) {
      final data = e.data();

      // returns and add a Job object to jobs list
      return Job(
        id: e.id,
        category: data['job_category'],
        jobTitle: data['job_title'],
        minSalary: data['min_salary'].toDouble(),
        maxSalary: data['max_salary'].toDouble(),
        experience: data['experience'],
        jobType: data['job_type'],
        jobSummary: data['job_description'],
        requirements: List<String>.from(data['requirements']),
        applicantCount: data['applicant_count'],
        timeUpdated: data['job_posted']
      );
    }).toList();

    return jobs;
  }

  // get specified data from specific doc
  static Future<List<dynamic>> getAllWithItems(String doc, Map<String, dynamic> items) async {

    final snapshot = await _db.collection(doc).get();

    List<dynamic> jobs = snapshot.docs.map((e) {
      final data = e.data();
      final job = items;
    }).toList();

    return jobs;
  }
}