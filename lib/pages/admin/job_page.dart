import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/icon_text.dart';
import 'package:dole_jobhunt/pages/admin/account_page.dart';
import 'package:dole_jobhunt/pages/admin/edit_job.dart';
import 'package:dole_jobhunt/pages/admin/view_applicants.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/dialog.dart';
import '../../globals/style.dart';
import '../../models/job.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key, required this.jobID});
  
  final String jobID;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {

  void _navigateToEdit(Job job) {
    
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => EditJobPage(job: job))
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
          IconButton(
              onPressed: () {
                // shows confimation dialogue
                showDialog(
                  context: context,
                  builder: (_) => CustomDialog(
                    title: Text('trash illustration here'),
                    content: Text('Delete this Job?'),

                    actions: <Widget>[
                      // cancel
                      Button(
                          content: Text('Cancel'),
                          color: light50,
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),

                      Button(
                          content: Text('Delete', style: TextStyle(color: light),),
                          color: red,
                          onPressed: () async {

                            // delete data from db
                            await FireStoreService.deleteJob(widget.jobID);

                            // wait 2 seconds
                            await Future.delayed(Duration(seconds: 2));

                            // navigate to job_list page
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                      ),
                    ],
                  ),

                  barrierDismissible: true
                );
              },

              icon: Icon(Icons.delete_rounded, color: red,)
          )
        ],
      ),

      body: FutureBuilder(
        future: FireStoreService.getJob(widget.jobID),
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
                  
                                Text("${job['purok']} ${job['baranggay']}, ${job['city']}", style: TextStyle(color: light),)
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
                              content: Text('Applicants (${job['applicants'].length})', style: TextStyle(fontWeight: bold),),
                              color: light,
                              onPressed: () => context.go('/admin_page/job_details/${widget.jobID}/view_applicants/')
                          ),
                        ),

                        const SizedBox(width: 20,),

                        Expanded(
                          child: Button(
                              content: Text('Edit', style: TextStyle(color: light, fontWeight: bold),),
                              color: secondaryColor,
                              onPressed: () {

                                Job jobData = Job(
                                  id: widget.jobID,
                                  category: job['job_category'],
                                  jobTitle: job['job_title'],
                                  minSalary: (job['min_salary'] as num).toDouble(),
                                  maxSalary: (job['max_salary'] as num).toDouble(),
                                  experience: job['experience'],
                                  jobType: job['job_type'],
                                  jobSummary: job['job_description'],
                                  requirements: List<String>.from(job['requirements']),
                                  companyName: job['company_name'],
                                );

                                _navigateToEdit(jobData);
                              }
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