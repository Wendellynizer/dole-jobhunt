import 'package:dole_jobhunt/util/pref_handler.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

import 'package:dole_jobhunt/globals/style.dart';
import 'package:dole_jobhunt/util/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // supabase init
  await Supabase.initialize(
      url: 'https://jevlqmkxmrddnfdmgdgx.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpldmxxbWt4bXJkZG5mZG1nZGd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI4NjQ5NDcsImV4cCI6MjA0ODQ0MDk0N30.X9oV76r8S7aFPZMndYLvu2DfmGEfHGlVxcVzNOnaIN8'
  );

  runApp(const MyApp());
}


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
      routerConfig: router,
    );
  }
}

