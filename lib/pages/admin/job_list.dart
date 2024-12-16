import 'dart:math';

import 'package:dole_jobhunt/components/searchbar.dart';
import 'package:dole_jobhunt/globals/data.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/icon_text.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../components/label.dart';
import '../../globals/style.dart';
import '../../models/job.dart';

class AdminJobList extends StatefulWidget {
  const AdminJobList({super.key});

  @override
  State<AdminJobList> createState() => _AdminJobListState();
}

class _AdminJobListState extends State<AdminJobList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs", style: headerStyle),
        backgroundColor: primaryColor,
      ),

      body: Padding(
        padding: horizontal,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // create job button
              Button(
                  content: Text("Create New Job", style: TextStyle(color: light),),
                  color: secondaryColor,
                  onPressed: () {
                    // navigate to create job page
                    context.go('/admin_page/create_job');
                  },
                  borderRadius: borderL,
              ),

              const SizedBox(height: 20,),

              // searchbar
              SearchBar(
                hintText: 'Search here...',
                leading: const Icon(Icons.search_rounded),
                backgroundColor:  WidgetStatePropertyAll(light),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: borderL
                )),
                elevation: const WidgetStatePropertyAll(1),
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 20)
                ),
              ),

              const SizedBox(height: 28,),

              StreamBuilder<List<dynamic>>(
                  stream: FireStoreService.getJobs(DataStorage.uid),
                  builder: (context, snapshot) {


                    // checks if snapshots has errors
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    // checks if snapshot is done fetching
                    if(snapshot.connectionState == ConnectionState.active) {

                      // shows no data message when there is no data
                      if(!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No jobs currently listed.'),);
                      }

                      // THE LIST!
                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverList.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (c, index) {

                              Job job = snapshot.data?[index];

                              // calculate days from jobs posted
                              Jiffy datePosted = Jiffy.parse(job.timeUpdated!);
                              final diffInDays =  Jiffy.now().diff(datePosted, unit: Unit.day);

                              return JobCard(
                                jobTitle: job.jobTitle,
                                companyName: job.companyName,
                                minSalary: job.minSalary,
                                maxSalary: job.maxSalary,
                                jobType: job.jobType,
                                jobExp: (job.experience > 0)
                                    ? '${job.experience}+ years experience'
                                    : 'Fresher',
                                jobPosted: diffInDays as int,
                                applicantCount: job.applicants!.length,
                                bottomMargin: 20,

                                routeTo: () {
                                  // route to job details page
                                  context.go('/admin_page/job_details/${job.id}');
                                },
                              );
                            },
                          )
                        ],
                      );
                    }
                    else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// job card widget holds all data for a card
class JobCard extends StatefulWidget {

  const JobCard({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.minSalary,
    required this.maxSalary,
    required this.jobType,
    required this.jobExp,
    required this.jobPosted,
    required this.applicantCount,
    required this.routeTo,
    this.bottomMargin
  });

  final String jobTitle;
  final String companyName;
  final double minSalary;
  final double maxSalary;
  final String jobType;
  final String jobExp;
  final int jobPosted;
  final int applicantCount;
  final double? bottomMargin;
  final Function()? routeTo;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {

  // get day history {Today, Yesterday, 3 day ago}
  String getDayHistory(int day) {

    if(day == 0) return 'Today';
    if(day == 1) return 'Yesterday';

    return '$day days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: (widget.bottomMargin == null)? 0 : widget.bottomMargin!),

      child: MaterialButton(
          // material button properties
          onPressed: widget.routeTo,
          color: light,
          padding: cardPadding,

          shape: RoundedRectangleBorder(borderRadius: borderSM),
          elevation: 0,

          child: Column(
            children: [
              // top (image, title, company name)
              Row(
                children: [
                  // company image
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xffffff).withOpacity(0.6),
                      borderRadius: borderSM,
                    ),
                    child: Image.network(
                    Supabase.instance.client.storage.from('file_uploads').getPublicUrl(DataStorage.imagePath),
                    fit: BoxFit.cover),
                  ),

                  const SizedBox(width: 14,),

                  // title & company name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.jobTitle, style: TextStyle(fontSize: text_lg, fontWeight: bold),),
                      // Text(widget.companyName, style: TextStyle(color: dark50, fontSize: text_xs, fontWeight: medium),),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              // salary details
              IconText(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  icon: Icon(Icons.payment_rounded, color: dark50, size: 28,),
                  content: Text(
                    "${widget.minSalary} - ${widget.maxSalary}/month",
                    style: TextStyle(
                        color: dark50, fontSize: text_md, fontWeight: semibold),
                  )),

              const SizedBox(height: 20,),

              // badges
              Row(
                children: [
                  Label(
                    icon: Icon(
                      Icons.schedule_rounded,
                      color: light,
                      size: 18,
                    ),
                    title: widget.jobType,
                    textStyle: TextStyle(
                      fontSize: text_xs,
                      color: light
                    ),
                  ),

                  const SizedBox(width: 8,),

                  Label(
                    icon: Icon(
                      Icons.work_outline_rounded,
                      color: light,
                      size: 18,
                    ),
                    title: widget.jobExp,
                    textStyle: TextStyle(
                        fontSize: text_xs,
                        color: light
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10,),

              Divider(color: dark50, thickness: 1,),

              // job post history and applicant
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconText(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    icon: Icon(Icons.history_rounded, color: dark50,),
                    content: Text(
                      getDayHistory(widget.jobPosted),
                      style: TextStyle(color: dark50, fontSize: text_sm),
                    ),
                    width: 6,
                  ),

                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: borderSM
                      ),

                      child: Text(
                      "${widget.applicantCount} applicant/s",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: text_sm,
                      ),
                    )
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
