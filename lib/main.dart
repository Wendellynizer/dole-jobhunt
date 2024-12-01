import 'package:dole_jobhunt/pages/admin/create_job.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:dole_jobhunt/globals/style.dart';
import 'package:dole_jobhunt/pages/admin/admin_page.dart';


void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const AdminPage(),

        routes: [
          GoRoute(
            path: 'create_job',
            builder: (context, state) => const CreateJobPage(),
          )
        ]
    ),


  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: primaryColor,
        useMaterial3: true,
      ),
      routerConfig: _router,

      // routes: _router,
      // home: const AdminPage(),
    );
  }
}

