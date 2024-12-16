import 'package:async/async.dart';
import 'package:dole_jobhunt/pages/user/home.dart';
import 'package:flutter/material.dart';
import 'package:dole_jobhunt/pages/user/applicant_setup.dart';
import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/globals/style.dart';
import 'package:dole_jobhunt/pages/admin/admin_page.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';

import '../globals/data.dart';
import '../util/pref_handler.dart';
import 'admin/company_setup.dart';

class CheckRolePage extends StatefulWidget {
  const CheckRolePage({super.key});

  @override
  State<CheckRolePage> createState() => _CheckRolePageState();
}

class _CheckRolePageState extends State<CheckRolePage> {

  final AsyncMemoizer<String?> _memoizer = AsyncMemoizer<String?>();
  final AsyncMemoizer<Map<String, dynamic>> _memoizer2 = AsyncMemoizer<Map<String, dynamic>>();

  String? _uid;
  int _selectedUser = -1;

  void _toggleUser(int value) {
    setState(() {
      _selectedUser = value;
    });
  }

  // handles which role setup to view (role selection, applicant setup, employer setup)
  Widget _getRoleView(String? role) {

    if(role == 'employer') return CompanySetupPage(uid: _uid);
    if(role == 'applicant') return ApplicantSetupPage(uid: _uid);

    return _roleSelection();
  }

  // processes _selectedUser value and route to appropriate setup
  void _process() {

    if(_selectedUser == -1) return;

    String role = (_selectedUser == 0)? 'applicant' : 'employer';
    final route = (_selectedUser == 0)? ApplicantSetupPage(uid: _uid!,) : CompanySetupPage(uid: _uid!);

    FireStoreService.update(
        'users',
        _uid!,
        {'role': role,}
    );

    Navigator.of(context).push(
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => route,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1000.0;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var opacityAnimation = animation.drive(tween);

              return FadeTransition(
                opacity: opacityAnimation,
                child: child,
              );
            }
        )
    );
  }

  Widget _roleSelection() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 26, right: 26,),

      child: Column(

        children: [
          const SizedBox(height: 40,),

          Text(
            'Take your first step and build your career!',
            style: TextStyle(fontSize: text_lg, fontWeight: semibold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20,),
          
          // applicant image button
          GestureDetector(
            onTap: () => _toggleUser(0),

            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: light,
                borderRadius: borderM,
                border: (_selectedUser == 0)
                    ? Border.all(color: secondaryColor, width: 4)
                    : Border.all(color: Colors.transparent, width: 4)
              ),

              child: Column(
                children: [
                  Image.asset('lib/images/applicant.png', width: 180,),
                  const SizedBox(height: 10,),
                  Text(
                    'Applicant',
                    style: TextStyle(fontSize: text_md, fontWeight: semibold),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20,),
          
          // employer image button
          GestureDetector(
            onTap: () => _toggleUser(1),

            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: light,
                  borderRadius: borderM,
                  border: (_selectedUser == 1)
                      ? Border.all(color: secondaryColor, width: 4)
                      : Border.all(color: Colors.transparent, width: 4)
              ),

              child: Column(
                children: [
                  Image.asset('lib/images/employer.png', width: 180,),
                  const SizedBox(height: 10,),
                  Text(
                    'Employer',
                    style: TextStyle(fontSize: text_md, fontWeight: semibold),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          Row(
            children: [
              Expanded(
                child: Button(
                    content: Text('Select', style: TextStyle(color: light, fontWeight: bold),),
                    color: secondaryColor,
                    onPressed: _process
                ),
              ),
            ],
          ),

          const SizedBox(height: 20,)
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<String?>(
          future: _memoizer.runOnce(() => PrefHandler.getPref('uid')), // get uid from pref
          builder: (context, snapshot) {

            // done fetching
            if(snapshot.connectionState == ConnectionState.done) {

              _uid = snapshot.data;

              DataStorage.uid = _uid!; // insert uid into DataStorage

              // get user data from db
              return FutureBuilder<Map<String, dynamic>>(
                  future: _memoizer2.runOnce(() => FireStoreService.getUser(_uid!)),
                  builder: (context, userSnapshot) {

                    // done fetching
                    if(userSnapshot.connectionState == ConnectionState.done) {

                      final user = userSnapshot.data; // get user data in Map

                      // check for keys that is exclusive for employers and route to dashboard
                      if(user!.containsKey('company_name')) {

                        DataStorage.purok = user['purok'];
                        DataStorage.baranggay = user['baranggay'];
                        DataStorage.city = user['city'];
                        DataStorage.imagePath = user['image_path'];
                        DataStorage.companyName = user['company_name'];

                        return const AdminPage();
                      }

                      // check for keys that is exclusive for applicants and route to Profile
                      if(user!.containsKey('gender')) {

                        DataStorage.purok = user['purok'];
                        DataStorage.baranggay = user['baranggay'];
                        DataStorage.city = user['city'];
                        DataStorage.imagePath = user['profile_path'];

                        return const Home();
                      }

                      // check and navigate to page according to role
                      return _getRoleView(user['role']);
                    }
                    else if(userSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // error
                    return const Text('Error');
                  }
              );
            }

            return const Text('Error');
          }
      ),
    );
  }
}

