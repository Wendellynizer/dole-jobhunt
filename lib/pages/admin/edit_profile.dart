import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';

class AdminEditProfile extends StatefulWidget {
  const AdminEditProfile({super.key});

  @override
  State<AdminEditProfile> createState() => _AdminEditProfileState();
}

class _AdminEditProfileState extends State<AdminEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(fontSize: text_lg, fontWeight: semibold)),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
    );
  }
}
