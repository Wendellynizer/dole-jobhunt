import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicantPage extends StatelessWidget {
  const ApplicantPage({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: shell.goBranch,
        currentIndex: shell.currentIndex,

        selectedItemColor: secondaryColor,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work_rounded),
            label: 'Jobs'
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Profile'
          )
        ],
      ),


      body: shell,
    );
  }
}
