import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/inputs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../globals/style.dart';
import '../services/auth.dart';
import '../util/pref_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Future<void> _login() async {
    emailCtrl.text = 'blaze@gmail.com';
    passwordCtrl.text = 'qwerty';

    // validate fields
    if(emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      print('empty field/s');

      return;
    }

    UserCredential? credential = await Auth.signIn(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim()
    );

    // check if there is user
    if(credential == null) {
      print('no account found');
      return;
    }

    // save uid in pref
    PrefHandler.savePref('uid', credential.user!.uid);

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
                  'Login',
                  style: TextStyle(fontSize: text_h5, fontWeight: semibold),
                ),

                const SizedBox(height: 10,),

                Text(
                  'Login in to your account.',
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
                   Expanded(
                     child: Button(
                       content: Text('Login', style: TextStyle(
                           color: light,
                           fontSize: 20,
                           fontWeight: semibold
                       ),),
                       color: secondaryColor,
                       borderRadius: borderSM,
                       onPressed: _login,
                     ),
                   ),
                 ],
               ),

                const SizedBox(height: 20,),

                // to sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),

                    const SizedBox(width: 5,),

                    GestureDetector(
                      onTap: () => context.go('/signup'),
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: secondaryColor, fontWeight: semibold),),
                    )
                  ],
                ),

                const SizedBox(height: 20,),

                const Text('or continue with'),

                const SizedBox(height: 20,),

                // google button
                Flex(
                  direction: Axis.horizontal,

                  children: [
                    Expanded(
                      child: Button(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Image.asset('lib/images/google-icon.webp', width: 30,),

                            const SizedBox(width: 10,),

                            Text('Google', style: TextStyle(
                                color: dark,
                                fontSize: 20,
                                fontWeight: semibold
                            ),),
                          ],
                        ),

                        color: light,
                        borderRadius: borderSM,
                        onPressed: () {},
                      ),
                    ),
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
