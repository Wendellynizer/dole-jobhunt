import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../globals/style.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {
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
                  ),

                  const SizedBox(height: 10,),

                  TextInput(
                    hintText: 'Last Name',
                  ),

                  const SizedBox(height: 10,),

                  TextInput(
                    hintText: 'Username',
                  ),

                  const SizedBox(height: 10,),

                  // password field
                  PassField(
                    hintText: 'Password',
                  ),

                  const SizedBox(height: 30,),

                  // login button
                  Flex(
                    direction: Axis.horizontal,

                    children: [
                      Expanded(
                        child: Button(
                          content: Text('Sign up', style: TextStyle(
                              color: light,
                              fontSize: 20,
                              fontWeight: semibold
                          ),),
                          color: secondaryColor,
                          borderRadius: borderSM,
                          onPressed: () {},
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
