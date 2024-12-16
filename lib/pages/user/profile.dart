import 'dart:math';

import 'package:dole_jobhunt/components/icon_text.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/label.dart';
import '../../globals/data.dart';
import '../../globals/style.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<Color> colors = [
    const Color(0xff006A67),
    const Color(0xff003161),
    const Color(0xffA64D79),
    const Color(0xff7A1CAC),
    const Color(0xff1E3E62),
    const Color(0xff3C3D37),
    const Color(0xffF97300),
  ];

  // returns random color from colors list
  Color generateColor() {
    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: light, fontWeight: bold),),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: secondaryColor,
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60),
          color: secondaryColor,
        
          child: Stack(
            clipBehavior: Clip.none,
            children: [
        
              // container
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                    color: primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                    )
                ),
        
                child: FutureBuilder(
                    future: FireStoreService.getUser(DataStorage.uid),
                    builder: (context, snapshot) {

                      if(snapshot.connectionState == ConnectionState.done) {

                        final user = snapshot.data!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const SizedBox(height: 80,),

                            // name, location, phone number
                            Center(child: Text(
                            "${user['first_name']} ${user['last_name']}", style: TextStyle(fontSize: text_lg, fontWeight: bold),)),

                            const SizedBox(height: 10,),

                            // address [baranggay, city]
                            IconText(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                width: 2,

                                icon: const Icon(Icons.location_on_outlined, size: 16,),
                                content: Text("${user['purok']} ${user['baranggay']}, ${user['city']}")
                            ),

                            const SizedBox(height: 10,),

                            // email
                            IconText(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                width: 2,

                                icon: const Icon(Icons.mail_outline_rounded, size: 16,),
                                content: Text(FirebaseAuth.instance.currentUser!.email!)
                            ),

                            const SizedBox(height: 10,),

                            // contact num
                            IconText(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                width: 2,

                                icon: const Icon(Icons.call_rounded, size: 16,),
                                content: Text(user['contact'])
                            ),

                            const SizedBox(height: 40,),

                            Padding(
                              padding: horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  // resume
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Files (resume, cv, etc.)',
                                        style: TextStyle(
                                            fontSize: text_md,
                                            fontWeight: semibold
                                        ),
                                      ),

                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.add_rounded, size: 18,)
                                      )
                                    ],
                                  ),

                                  const SizedBox(height: 10,),

                                  const SizedBox(height: 30,),

                                  // profile summary
                                  Text(
                                    'Profile Summary',
                                    style: TextStyle(
                                        fontSize: text_md,
                                        fontWeight: semibold
                                    ),
                                  ),

                                  const SizedBox(height: 10,),

                                  Text(
                                    'A passionate software engineer with over 5 years '
                                        'of experience in developing mobile applications. '
                                        'I have a strong background in building user-friendly '
                                        'interfaces and optimizing application performance. '
                                        'I thrive in collaborative environments and am always '
                                        'eager to learn new technologies. My goal is to '
                                        'leverage my skills to contribute to innovative projects '
                                        'and help teams achieve their objectives.',
                                    style: TextStyle(
                                      color: dark50,
                                      fontSize: text_sm,
                                      fontWeight: medium,
                                    ),
                                    // textAlign: TextAlign.justify,
                                  ),

                                  const SizedBox(height: 30,),

                                  // skills
                                  Text('My Skills', style: TextStyle(fontSize: text_md, fontWeight: semibold)),
                                  const SizedBox(height: 10,),
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: [
                                      SkillTag(text: 'UI Design', bgColor: generateColor(),),
                                      SkillTag(text: 'UX Design', bgColor: generateColor()),
                                      SkillTag(text: 'Wireframe', bgColor: generateColor()),
                                      SkillTag(text: 'Motion Graphic', bgColor: generateColor()),
                                      SkillTag(text: 'Figma', bgColor: generateColor()),
                                      SkillTag(text: 'After Effects', bgColor: generateColor()),
                                    ],
                                  ),

                                  const SizedBox(height: 30,),

                                  // education
                                  Text('Education', style: TextStyle(fontSize: text_md, fontWeight: semibold)),
                                  const SizedBox(height: 10,),

                                  InfoCard(
                                    icon: Icons.school_rounded,
                                    title: 'Davao del Norte State College',
                                    subtitle: '2000-present',
                                  ),

                                  const SizedBox(height: 10,),

                                  InfoCard(
                                    icon: Icons.school_rounded,
                                    title: 'North Davao Colleges',
                                    subtitle: '1950-1990',
                                  ),

                                  const SizedBox(height: 20,),

                                  // experience
                                  Text('Experience', style: TextStyle(fontSize: text_md, fontWeight: semibold)),
                                  const SizedBox(height: 10,),

                                  ExperienceCard(
                                      jobTitle: 'UI/UX Designer',
                                      companyName: 'Creative Corp.',
                                      description: 'This is a summary.',
                                      date: '2020-2024'
                                  ),

                                  const SizedBox(height: 20,),

                                  //certifications
                                  Text('Certifications', style: TextStyle(fontSize: text_md, fontWeight: semibold)),
                                  const SizedBox(height: 10,),

                                  const InfoCard(icon: Icons.workspace_premium_rounded, title: 'Certificate A', subtitle: '2022',),

                                  const SizedBox(height: 20,),
                                ],
                              ),
                            )
                          ],
                        );

                      }


                      return Center(child: Text('Loading...'),);
                    }
                )
              ),
        
              // profile
              Positioned(
                top: -50,
                left: 0,
                right: 0,
        
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: secondaryColor,
                        width: 4
                    )
                  ),
        
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        Supabase.instance.client.storage.from('file_uploads').getPublicUrl(DataStorage.imagePath)
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.jobTitle, required this.companyName, required this.description, required this.date});

  final String jobTitle;
  final String companyName;
  final String date;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: cardPadding,
      decoration: BoxDecoration(
          color: light,
          borderRadius: borderSM
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(jobTitle,
                  style: TextStyle(fontSize: text_md, fontWeight: semibold, color: dark50)),

              Text(companyName,
                  style: TextStyle(fontSize: text_sm, fontWeight: medium, color: dark50)),

              const SizedBox(height: 20,),

              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75
                ),

                child: Text(description, style: TextStyle(fontSize: text_sm, color: dark50)
                ),
              ),

              const SizedBox(height: 20,),
              Text(date, style: TextStyle(fontSize: text_xs, color: dark50)),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: light,
          borderRadius: borderSM
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // icon
          Container(
            decoration: const BoxDecoration(
              color: Color(0x22000000),
            ),

            padding: const EdgeInsets.all(14),

            child: Icon(icon, color: Color(0x44000000),),
          ),

          const SizedBox(width: 10,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: semibold, color: dark50)),
              const SizedBox(height: 4,),
              Text(subtitle, style: TextStyle(fontSize: text_xs, color: dark50),)
            ],
          )
        ],
      ),
    );
  }
}

class SkillTag extends StatelessWidget {
  const SkillTag({super.key, required this.text, this.bgColor});

  final String text;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
          color: (bgColor == null)?const Color(0xffF97300) : bgColor,
          borderRadius: borderSM
      ),

      child: Text(text, style: TextStyle(color: light),),
    );
  }
}

