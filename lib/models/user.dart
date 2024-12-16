
class AppUser {

  AppUser({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role,
    this.dateJoined
  });

  String? id;
  String firstName;
  String lastName;
  String email;
  String? role;
  String? dateJoined;

  toJSON() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role': role = '',
      'date_joined': dateJoined
    };
  }
}