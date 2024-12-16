import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/icon_text.dart';
import '../../globals/style.dart';
import '../../services/firestore_service.dart';
import '../user/profile.dart';

class ApplicantProfile extends StatefulWidget {
  final String applicantID;

  const ApplicantProfile({super.key, required this.applicantID});

  @override
  State<ApplicantProfile> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {

  String imagePath = '';

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
        foregroundColor: light,
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
                        future: FireStoreService.getUser(widget.applicantID),
                        builder: (context, snapshot) {
      
                          if(snapshot.connectionState == ConnectionState.done) {
      
                            final user = snapshot.data!;
      
                            imagePath = user['profile_path'];
      
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
                                    content: Text(user['email'])
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

                                  child: FutureBuilder(
                                    future: FireStoreService.getProfile(widget.applicantID),
                                    builder: (context, profileSnapshot) {

                                      if(profileSnapshot.connectionState == ConnectionState.done) {

                                        final data = profileSnapshot.data;

                                        final profileSummary = data?['profile_summary'];
                                        final skills = data?['skills'] != null
                                            ? List<String>.from(data!['skills'])
                                            : [];
                                        final education = data?['education'] != null
                                            ? List<Map<String, dynamic>>.from(data!['education'])
                                            : [];
                                        final experience = data?['experience'] != null
                                            ? List<Map<String, dynamic>>.from(data!['experience'])
                                            : [];
                                        final certificates = data?['certificates'] != null
                                            ? List<Map<String, dynamic>>.from(data!['certificates'])
                                            : [];

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
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
                                              (profileSummary != null)? profileSummary : 'No Profile Summary.',
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
                                            (skills.isNotEmpty)
                                              ? Wrap(
                                              spacing: 4,
                                              runSpacing: 4,

                                              children: skills.map((skill) {
                                                return SkillTag(text: skill, bgColor: generateColor(),);
                                              }).toList(),

                                            )
                                              : const Text('No Skills.'),

                                            const SizedBox(height: 30,),

                                            // education
                                            Text('Education', style: TextStyle(fontSize: text_md, fontWeight: semibold)),
                                            const SizedBox(height: 10,),

                                            (education.isNotEmpty)
                                                ? Column(
                                              children: education.map((educ) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),

                                                  child: InfoCard(
                                                      icon: Icons.school_rounded,
                                                      title: educ['institute'],
                                                      subtitle: "${educ['start_year']}-${educ['end_year']}"
                                                  ),
                                                );
                                              }).toList(),
                                            )
                                                : const Text('No Education.'),

                                            const SizedBox(height: 20,),

                                            // experience
                                            Text('Experience', style: TextStyle(fontSize: text_md, fontWeight: semibold)),
                                            const SizedBox(height: 10,),

                                            (experience.isNotEmpty)
                                              ? Column(
                                              children: experience.map((exp) {
                                                return Padding(
                                                    padding: const EdgeInsets.only(bottom: 10),
                                                    child:  ExperienceCard(
                                                        jobTitle: exp['job_title'],
                                                        companyName: exp['company'],
                                                        description: exp['summary'],
                                                        date: '${exp['start_year']}-${exp['end_year']}'
                                                    ),
                                                );
                                              }).toList(),
                                            )
                                              : const Text('No Experience.'),

                                            const SizedBox(height: 20,),

                                            //certifications
                                            Text('Certifications', style: TextStyle(fontSize: text_md, fontWeight: semibold)),
                                            const SizedBox(height: 10,),

                                            (certificates.isNotEmpty)
                                              ? Column(
                                              children: certificates.map((cert) {
                                                return Padding(
                                                    padding: const EdgeInsets.only(bottom: 10),

                                                    child: InfoCard(
                                                      icon: Icons.workspace_premium_rounded,
                                                      title: cert['certificate_name'],
                                                      subtitle: cert['year_issued'],
                                                    ),
                                                );
                                              }).toList(),
                                            )
                                              : const Text('No Certificates.'),

                                            const SizedBox(height: 20,),
                                          ],
                                        );
                                      }

                                      return const Center(child: CircularProgressIndicator(),);
                                    }
                                  ),
                                )
                              ],
                            );
      
                          }
      
      
                          return const Center(child: Text('Loading...'),);
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
                          Supabase.instance.client.storage.from('file_uploads').getPublicUrl(imagePath)
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
