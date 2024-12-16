import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dole_jobhunt/pages/admin/account_page.dart';
import 'package:flutter/material.dart';

import '../../components/buttons.dart';
import '../../components/dialog.dart';
import '../../components/icon_text.dart';
import '../../globals/data.dart';
import '../../globals/style.dart';
import '../../models/job.dart';
import '../../services/firestore_service.dart';

class JobView extends StatefulWidget {

  const JobView({super.key, required this.jobID});

  final String? jobID;

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {

  _applyJob() async {
    final DocumentReference docRef = FirebaseFirestore.instance.collection('jobs').doc(widget.jobID);
    docRef.update({
      'applicants': FieldValue.arrayUnion([DataStorage.uid])
    });
  }

  _confirmApply() {
    showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(
            backgroundColor: primaryColor,

            title: Text('Do you want to apply to this job?'),

            actions: [
              // no
              Button(
                  content: Text('No'),
                  color: light,
                  onPressed: () => Navigator.of(context).pop()
              ),

              // yes
              Button(
                  content: Text('Yes', style: TextStyle(color: light),),
                  color: secondaryColor,
                  onPressed: _applyJob
              ),
            ],
          );
        }
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: light,
          title: Text('Job Details', style: TextStyle(fontSize: text_lg, fontWeight: semibold)),
          backgroundColor: secondaryColor,
          centerTitle: true,

          actions: [

          ],
        ),

        body: FutureBuilder(
          future: FireStoreService.getJob(widget.jobID!),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.done) {

              // get job properties
              final job = snapshot.data as Map<String, dynamic>;

              List<dynamic> requirements = job['requirements'];

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // job titles, location, company name
                        Container(
                          color: secondaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 20),


                          child: Column(

                            children: [
                              Text(job['job_title'], style: TextStyle(color: light, fontSize: text_h3, fontWeight: bold),),

                              const SizedBox(height: 10,),

                              Text(job['company_name'], style: TextStyle(color: light50, fontSize: 16, fontWeight: semibold),),

                              const SizedBox(height: 10,),

                              // location
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_outlined, color: light,),

                                  const SizedBox(width: 10,),

                                  Text("${job['baranggay']}, ${job['city']}", style: TextStyle(color: light),)
                                ],
                              )
                            ],
                          ),
                        ),

                        // job salary, type, and experience
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),

                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),

                            decoration: BoxDecoration(
                                color: light,
                                borderRadius: border
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                // salary
                                Column(
                                  children: [
                                    Text('Salary', style: TextStyle(fontWeight: semibold, color: Color(0x55000000)),),
                                    const SizedBox(height: 10,),
                                    Text('₱ ${job['min_salary']} -', style: TextStyle(fontWeight: semibold, fontFamily: 'Roboto')),
                                    Text('${job['max_salary']}/m', style: TextStyle(fontWeight: semibold, fontFamily: 'Roboto'),)
                                  ],
                                ),

                                const SizedBox(width: 20,),

                                // job type
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Job Type', style: TextStyle(fontWeight: semibold, color: Color(0x55000000)),),
                                    const SizedBox(height: 10,),
                                    Text(job['job_type'], style: TextStyle(fontWeight: semibold,))
                                  ],
                                ),

                                const SizedBox(width: 20,),

                                // experience
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Experience', style: TextStyle(fontWeight: semibold, color: Color(0x55000000)),),
                                    const SizedBox(height: 10,),
                                    Text(
                                        (job['experience'] > 0)
                                            ?'${job['experience'].toString()}+'
                                            :'Fresher',
                                        style: TextStyle(fontWeight: semibold)
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // job details and requirements
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 100, left: 26, right: 26),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text('Requirements', style: TextStyle(fontSize: text_md, fontWeight: bold),),

                              const SizedBox(height: 10,),

                              Column(
                                children: requirements.map((item) {
                                  return IconText(
                                      bottomMargin: 30,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      icon: const Icon(Icons.circle, size: 10,),
                                      content: ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * 0.7
                                        ),

                                        child: Text(item, style: TextStyle(fontWeight: semibold),),
                                      )
                                  );
                                }).toList(),
                              ),

                              const SizedBox(height: 50,),

                              Text('Job Description', style: TextStyle(fontSize: text_md, fontWeight: bold),),

                              const SizedBox(height: 10,),

                              Text(job['job_description'], style: TextStyle(color: dark50),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // action buttons
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,

                    child: Padding(
                      padding: horizontal,

                      child: Row(
                        children: [
                          Expanded(
                            child: Button(
                                content: Text('Apply', style: TextStyle(fontWeight: bold, color: light),),
                                color: secondaryColor,
                                onPressed: _confirmApply
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }
}
