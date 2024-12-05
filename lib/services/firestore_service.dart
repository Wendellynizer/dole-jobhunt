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

  // get data specific only
  // static Future<Map<String, dynamic>> get(String docName, String id) async {
  //   final snapshot = await _db.collection(docName).doc(id).get();
  //
  //   if(snapshot.exists) {
  //     return snapshot.data() as Map<String, dynamic>;
  //   }
  //
  //   return {};
  // }

  static Future<Map<String, dynamic>> getJob(String id) async {
    final snapshot = await _db.collection('jobs').doc(id).get();

    if(snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }

    return {};
  }
  // get all data from specific doc
  static Stream<List<Job>> getAllJob() {
    // Use snapshots() to get a stream of document snapshots
    return _db.collection('jobs').snapshots().map((snapshot) {
      List<Job> jobs = [];
      try {
        jobs = snapshot.docs.map((e) {
          final data = e.data(); // Cast to Map<String, dynamic>

          // Create and return a Job object
          return Job(
            id: e.id,
            category: data['job_category'],
            jobTitle: data['job_title'],
            minSalary: (data['min_salary'] as num).toDouble(), // Ensure it's a number
            maxSalary: (data['max_salary'] as num).toDouble(), // Ensure it's a number
            experience: data['experience'],
            jobType: data['job_type'],
            jobSummary: data['job_description'],
            requirements: List<String>.from(data['requirements']), // Handle potential null
            applicantCount: data['applicant_count'], // Handle potential null
            timeUpdated: data['job_posted'], // Handle potential null
          );
        }).toList();
      } catch (e) {
        print('Error while mapping: $e');
      }
      return jobs; // Return the list of jobs
    });
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


  // updates entry in the db
  static update(String docName, String id, Map<String, dynamic> data) {

    final item = _db.collection(docName).doc(id);

    item.update(data).then((value) => print('update completed'));
  }
}