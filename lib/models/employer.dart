
import 'package:dole_jobhunt/models/user.dart';

class Employer {

  Employer({
    required this.app,
    required this.companyName,
    required this.companyEmail,
    required this.address
  });

  AppUser app;
  String companyName;
  String companyEmail;
  String address;

  toJSON() {
    return {
      'first_name': app.firstName,
      'last_name': app.lastName,
      'email': app.email,
      'role': app.role,
      'date_joined': app.dateJoined
    };
  }
}