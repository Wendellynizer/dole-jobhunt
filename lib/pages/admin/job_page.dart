import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/pages/admin/edit_job.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:flutter/material.dart';

import '../../globals/style.dart';
import '../../models/job.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key, required this.jobID});
  
  final String jobID;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {

  late Future<Map<String, dynamic>> _jobFuture;
  String _jobName = 'Job Details';

  @override
  void initState() {
    super.initState();
    _jobFuture = FireStoreService.getJob(widget.jobID);
  }

  Future<void> _refreshJob() async {
    setState(() {
      print('update!');
      _jobFuture = FireStoreService.getJob(widget.jobID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_jobName, style: headerStyle),
        backgroundColor: primaryColor,
      ),

      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _jobFuture,
            builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.done) {

                final jobName = snapshot.data as Map<String, dynamic>;

                // print(job);
                final job = Job(
                  id: widget.jobID,
                  category: jobName['job_category'],
                  jobTitle: jobName['job_title'],
                  jobType: jobName['job_type'],
                  minSalary: jobName['min_salary'].toDouble(),
                  maxSalary: jobName['max_salary'].toDouble(),
                  experience: jobName['experience'],
                  jobSummary: jobName['job_description'],
                  requirements: (jobName['requirements'] as List<dynamic>).map((item) => item as String).toList(),
                );

                return Column(
                  children: [
                    Text(job.category),
                    Text(job.jobTitle),
                    Text(job.minSalary.toString()),
                    Text(job.maxSalary.toString()),
                    Text(job.jobType),
                    Text(job.jobSummary),
                    Text(job.experience.toString()),
                    // Text(job['job_description']),

                    Row(
                      children: [
                        Button(
                            content: Text('See Applicants'),
                            color: secondaryColor,
                            onPressed: () {}
                        ),

                        const SizedBox(width: 20,),

                        Button(
                            content: Text('Edit'),
                            color: secondaryColor,
                            onPressed: () async {
                              final result = Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => EditJobPage(job: job)
                                  )
                              );

                              if(result == true) {
                                _refreshJob();
                              }
                            }
                        ),
                      ],
                    )
                  ],


                );
              }
              else {
                return const Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      )
    );
  }
}
