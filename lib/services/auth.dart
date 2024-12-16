import 'dart:ui';

import 'package:dole_jobhunt/models/user.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiffy/jiffy.dart';

class Auth {

  static final _auth = FirebaseAuth.instance;


  // register a user to firebase auth and additional data to
  // firestore
  static Future<UserCredential?> register({
    required String fname,
    required String lname,
    required String email,
    required String password,
    VoidCallback? onCompleted
  }) async {

    try {
      // register email/pass to firebase auth
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );

      // create user data in firestore
      AppUser appUser = AppUser(
          id: credential.user!.uid,
          firstName: fname,
          lastName: lname,
          email: email,
          dateJoined: Jiffy.now().format()
      );

      FireStoreService.createUser(appUser.id!, appUser.toJSON(), onCompleted: onCompleted);

      return credential;

    } catch(e) {

      print(e);

      return null;
    }
  }


  // sign ins a user
  static Future<UserCredential?> signIn({required String email, required String password,}) async {

    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return credential;

    } catch(e) {
      print('Error message: $e');
      return null;
    }
  }

  // sign ins a user via google
  void signInWithGoogle() {

  }


  static void signOut() {
    FirebaseAuth.instance.signOut();
  }
}