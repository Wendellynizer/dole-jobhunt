import 'package:dole_jobhunt/components/searchbar.dart';
import 'package:dole_jobhunt/main.dart';
import 'package:flutter/material.dart';

import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/icon_text.dart';
import 'package:go_router/go_router.dart';
import '../../components/label.dart';
import '../../globals/style.dart';

class AdminJobList extends StatefulWidget {
  const AdminJobList({super.key});

  @override
  State<AdminJobList> createState() => _AdminJobListState();
}

class _AdminJobListState extends State<AdminJobList> {

  // dummy data
  List jobCardsData = [
    ["IT Support", "XYZ Company", 20000, 30000.00, "Full Time", "1 year exp", 1, 12],
    ["Janitor", "Giyoo's Company", 20000.0, 30000.0, "Part Time", "Fresher", 3, 7],
    ["IT Support", "XYZ Company", 20000, 30000.00, "Full Time", "1 year exp", 1, 12],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs", style: headerStyle),
        backgroundColor: primaryColor,
      ),


      body: Padding(
        padding: horizontal,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // create job button
            Button(
                content: Text("Create New Job", style: TextStyle(color: light),),
                color: secondaryColor,
                onPressed: () {
                  // navigate to create job page
                  context.go('/create_job');
                },
                borderRadius: borderSM,
            ),

            const SizedBox(height: 20,),

            // search bar
            CustomSearchBar(),

            const SizedBox(height: 28,),

            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: jobCardsData.length,
                    itemBuilder: (context, index) {
                      print(jobCardsData.length);
                      print("building item #$index");
                      // all data here are only dummy
                      return JobCard(
                        jobTitle: jobCardsData[index][0],
                        companyName: jobCardsData[index][1],
                        minSalary: jobCardsData[index][2].toDouble(),
                        maxSalary: jobCardsData[index][3].toDouble(),
                        jobType: jobCardsData[index][4],
                        jobExp: jobCardsData[index][5],
                        jobPosted: jobCardsData[index][6],
                        applicantCount: jobCardsData[index][7],
                        bottomMargin: 15,
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// job card widget holds all data for a card
class JobCard extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: (bottomMargin == null)? 0 : bottomMargin!),
      child: MaterialButton(
          // material button properties
          onPressed: () {},
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
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x000000).withOpacity(0.2),
                          blurRadius: 1,
                        )
                      ]
                    ),

                    child: Image.asset('lib/images/google-icon.webp', fit: BoxFit.cover),
                  ),

                  const SizedBox(width: 14,),

                  // title & company name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(jobTitle, style: TextStyle(fontSize: text_lg, fontWeight: bold),),
                      Text(companyName, style: TextStyle(color: dark50, fontSize: text_xs, fontWeight: medium),),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              // salary details
              IconText(
                  icon: Icon(Icons.payment_rounded, color: dark50, size: 28,),
                  content: Text(
                    "$minSalary - $maxSalary/month",
                    style: TextStyle(
                        color: dark50, fontSize: text_lg, fontWeight: semibold),
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
                    title: jobType,
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
                    title: jobExp,
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
                      icon: Icon(Icons.history_rounded, color: dark50,),
                    content: Text(
                      (jobPosted == 0)? "Today" : "$jobPosted day/s ago",
                      style: TextStyle(color: dark50, fontSize: text_md),
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
                      "$applicantCount Applicant/s",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: text_md,
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
