import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/globals/style.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ViewApplicantsPage extends StatefulWidget {

  const ViewApplicantsPage({super.key, required this.jobID});

  final String jobID;

  @override
  State<ViewApplicantsPage> createState() => _ViewApplicantsPageState();
}

class _ViewApplicantsPageState extends State<ViewApplicantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: light,
        backgroundColor: secondaryColor,
        surfaceTintColor: Colors.transparent,
        title: Text('Applicants', style: TextStyle(fontSize: text_lg, fontWeight: semibold)),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),

        child: FutureBuilder(
            future: FireStoreService.getJob(widget.jobID),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.done) {
                // get applicant ids
                var applicantIDS = snapshot.data!['applicants'];

                return StreamBuilder(
                    stream: _getUsersStream(applicantIDS),
                    builder: (context, userSnapshot) {

                        if(userSnapshot.connectionState == ConnectionState.active) {
                          final users = userSnapshot.data;

                          return SizedBox(

                            child: ListView.separated(
                                itemCount: users!.length,
                                separatorBuilder: (context,index) => const SizedBox(height: 4,),
                                itemBuilder: (context, index) {

                                  String uid = users[index].id;
                                  String imagePath = users[index]['profile_path'];
                                  String fullName = "${users[index]['last_name']}, ${users[index]['first_name']}";
                                  String email = users[index]['email'];

                                  return Column(
                                    children: [
                                      const SizedBox(height: 10,),

                                      Container(
                                        padding: cardPadding,
                                        decoration: BoxDecoration(
                                          color: light,
                                          borderRadius: border
                                        ),

                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                context.go('/admin_page/job_details/${widget.jobID}/applicant/$uid');
                                              },

                                              child: CircleAvatar(
                                                  radius: 24,
                                                  backgroundImage: NetworkImage(Supabase.instance.client.storage.from('file_uploads').getPublicUrl(imagePath))
                                              ),
                                            ),

                                            const SizedBox(width: 10,),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(fullName, style: TextStyle(fontSize: text_md, fontWeight: bold),),
                                                Text(email, style: TextStyle(fontSize: text_xs),),
                                              ],
                                            ),

                                            const Spacer(),

                                            Button(
                                                padding: const EdgeInsets.all(6),
                                                borderRadius: borderSM,
                                                content: Icon(Icons.description_outlined, color: light,),
                                                color: secondaryColor,
                                                onPressed: () {}
                                            ),

                                            Button(
                                                padding: const EdgeInsets.all(6),
                                                borderRadius: borderSM,
                                                content: Icon(Icons.delete_rounded, color: light,),
                                                color: red,
                                                onPressed: () {}
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                            ),
                          );
                        }

                        return const Center(child: Text('ads'));
                    }
                );
              }

              return const Center(child: CircularProgressIndicator());
            }
        )
      ),
    );
  }
}

Stream<List<DocumentSnapshot>> _getUsersStream(List<dynamic> ids) {

  // Create a list of streams for each document
  List<Stream<DocumentSnapshot>> streams = ids.map((id) {
    return FirebaseFirestore.instance.collection('users').doc(id).snapshots();
  }).toList();

  // Combine the streams into a single stream
  return StreamZip(streams).map((snapshots) {
    return snapshots; // Return the list of DocumentSnapshots
  });
}
