import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/job.dart';

class FireStoreService {

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // creates entry in the db
  static create(String doc, Map<String, dynamic> data, {VoidCallback? onCompleted}) async {

    _db.collection(doc).add(data).whenComplete(() {
      if(onCompleted != null) onCompleted;
    });
  }

  // creates    a user in the db
  static createUser(String uid, Map<String, dynamic> data, {VoidCallback? onCompleted}) async {

    try {
      _db.collection('users').doc(uid).set(data).whenComplete(() {
        if(onCompleted != null) onCompleted;
      });
    } catch(e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>> getUser(String id) async {
    final snapshot = await _db.collection('users').doc(id).get();

    if(snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }

    return {};
  }


  // get specific job
  static Future<Map<String, dynamic>> getJob(String id) async {
    final snapshot = await _db.collection('jobs').doc(id).get();

    if(snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }

    return {};
  }

  static Future<Map<String, dynamic>> getProfile(String ownerID) async {
    final querySnapshot = await _db.collection('profiles').where('applicant_id', isEqualTo: ownerID).get();

    // Check if any documents were found
    if (querySnapshot.docs.isNotEmpty) {
      // Assuming you want the first document that matches the query
      final doc = querySnapshot.docs.first;
      return doc.data(); // Return the document data as a Map
    } else {
      // Return an empty map or handle the case where no profile is found
      return {};
    }
  }

  // get all jobs from a company
  static Stream<List<Job>> getJobs(String ownerID) {
    // Use snapshots() to get a stream of document snapshots
    return _db.collection('jobs').where('owner_id', isEqualTo: ownerID).snapshots().map((snapshot) {
      List<Job> jobs = [];
      try {
        jobs = snapshot.docs.map((e) {
          final data = e.data(); // Cast to Map<String, dynamic>

          // Create and return a Job object
          return Job(
            id: e.id,
            companyName: data['company_name'],
            category: data['job_category'],
            jobTitle: data['job_title'],
            minSalary: (data['min_salary'] as num).toDouble(), // Ensure it's a number
            maxSalary: (data['max_salary'] as num).toDouble(), // Ensure it's a number
            experience: data['experience'],
            jobType: data['job_type'],
            jobSummary: data['job_description'],
            requirements: List<String>.from(data['requirements']), // Handle potential null
            applicants:  List<String>.from(data['applicants']), // Handle potential null
            timeUpdated: data['job_posted'], // Handle potential null
          );
        }).toList();
      } catch (e) {
        print('Error while mapping: $e');
      }
      return jobs; // Return the list of jobs
    });
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
            companyName: data['company_name'],
            category: data['job_category'],
            jobTitle: data['job_title'],
            minSalary: (data['min_salary'] as num).toDouble(), // Ensure it's a number
            maxSalary: (data['max_salary'] as num).toDouble(), // Ensure it's a number
            experience: data['experience'],
            jobType: data['job_type'],
            jobSummary: data['job_description'],
            requirements: List<String>.from(data['requirements']), // Handle potential null
            applicants: data['applicants'], // Handle potential null
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
  static Future<List<Map<String, dynamic>>> getAllWithField(String doc) async {

    final snapshot = await _db.collection(doc).get();

    List<Map<String, dynamic>> jobs = snapshot.docs.map((doc) {
      final data = doc.data();

      return {
        'id': doc.id,
        'city': data['city'],
        'imagePath': data['image_path'],
        'companyName': data['company_name'],
        'jobTitle': data['job_title'],
        'jobType': data['job_type'],
        'experience': data['experience'],
        'minSalary': data['min_salary'],
        'maxSalary': data['max_salary'],
        'date': data['job_posted']
      };
    }).toList(); 

    return jobs;
  }

  // delete specific job
  static Future<void> deleteJob(String id) async {
    _db.collection('jobs').doc(id).delete().then(
        (doc) => print("job deleted!")
    );
  }

  // updates entry in the db
  static update(String docName, String id, Map<String, dynamic> data) {

    final item = _db.collection(docName).doc(id);

    item.update(data).then((value) => print('update completed'));
  }
}