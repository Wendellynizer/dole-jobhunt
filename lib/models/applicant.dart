
import 'package:dole_jobhunt/models/user.dart';

class Applicant extends AppUser {

  Applicant({
    required super.firstName,
    required super.lastName,
    required super.email,
    required this.contact,
    required this.prk,
    required this.brgy,
    required this.city,
    required this.gender,
  });

  String contact;
  String prk;
  String brgy;
  String city;
  String gender;


  toJSON() {
    return {
      ""
    };
  }
}