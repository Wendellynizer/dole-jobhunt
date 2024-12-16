import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/inputs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../globals/style.dart';
import '../services/auth.dart';
import '../util/pref_handler.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {

  final fnameCtrl = TextEditingController();
  final lnameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool isLoading = false;

  void _signup() async {

    UserCredential? credential = await Auth.register(
        fname: fnameCtrl.text.trim(),
        lname: lnameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
        onCompleted: () {
          setState(() {
            isLoading = false;
            print('done');
          });
        }
    );

    PrefHandler.savePref('uid', credential!.user!.uid);

    // navigate to checkrolepage after signing up
    if(mounted) {
      context.go('/check_role');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 26, right: 26,),

          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  // idk ngano ni pero ni expand ang cross axis width sa container HAHAHAHAH
                  const Flex(
                    direction: Axis.horizontal,
                  ),

                  // top text
                  Text(
                    "Let's Sign You Up!",
                    style: TextStyle(fontSize: text_h5, fontWeight: semibold),
                  ),

                  const SizedBox(height: 10,),

                  Text(
                    'Let’s make you an account.',
                    style: TextStyle(fontSize: text_sm),
                  ),

                  const SizedBox(height: 30,),

                  // dole logo
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          left: 15,
                          top: 10,
                          child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                'lib/images/dole_logo.png',
                                width: 150,
                              ))),
                      Image.asset(
                        'lib/images/dole_logo.png',
                        width: 150,
                      ),
                    ],
                  ),

                  const SizedBox( height: 50,),

                  TextInput(
                    hintText: 'First Name',
                    controller: fnameCtrl,
                  ),

                  const SizedBox(height: 10,),

                  TextInput(
                    hintText: 'Last Name',
                    controller: lnameCtrl,
                  ),

                  const SizedBox(height: 10,),

                  TextInput(
                    hintText: 'Email',
                    controller: emailCtrl,
                  ),

                  const SizedBox(height: 10,),

                  // password field
                  PassField(
                    hintText: 'Password',
                    controller: passwordCtrl,
                  ),

                  const SizedBox(height: 30,),

                  // login button
                  Flex(
                    direction: Axis.horizontal,

                    children: [
                      // sign up button
                      Expanded(
                        child: Button(
                          content: isLoading
                              ? Container(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(color: primaryColor, strokeWidth: 3,)
                                )
                              : Text('Sign up', style: TextStyle(
                                    color: light,
                                    fontSize: 20,
                                    fontWeight: semibold
                                ),),

                          color: secondaryColor,
                          borderRadius: borderSM,

                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });

                            _signup();
                          }
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),

                  // to sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),

                      const SizedBox(width: 5,),

                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: Text(
                          'Log in',
                          style: TextStyle(color: secondaryColor, fontWeight: semibold),),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
