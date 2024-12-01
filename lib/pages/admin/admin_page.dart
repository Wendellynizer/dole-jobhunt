import 'package:dole_jobhunt/pages/admin/job_list.dart';
import 'package:flutter/material.dart';

import '../../globals/style.dart';
import 'account_page.dart';
import 'dashboard.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  // list of pages
  final List<Widget> _pages = [
    const AdminDashboard(),
    const AdminJobList(),
    const AdminAccountPage(),
  ];

  // index used for _pages
  int  _selectedIndex = 0;

  // changes the selected page shown
  void onTapPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapPressed,
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem (
              icon: Icon(Icons.home_rounded),
              label: 'Home'
          ),

          BottomNavigationBarItem (
              icon: Icon(Icons.work_rounded),
              label: 'Jobs'
          ),

          BottomNavigationBarItem (
              icon: Icon(Icons.account_box_rounded),
              label: 'Account'
          )
        ],
      ),

      body: _pages[_selectedIndex],
    );
  }
}
