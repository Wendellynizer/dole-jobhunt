import 'dart:math';
import 'package:dole_jobhunt/components/jobcard_list.dart';
import 'package:dole_jobhunt/globals/style.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/colored_jobcard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
        backgroundColor: primaryColor,
        surfaceTintColor: primaryColor,

        title: Text('Home', style: TextStyle(fontWeight: bold),),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('lib/images/job.png',),
            ),
          )
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26),

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),

              // hello message
              Row(
                children: [
                  Text('Hello, ', style: TextStyle(fontSize: text_xl, fontWeight: semibold),),
                  Text('User!', style: TextStyle(fontSize: text_xl, fontWeight: semibold, color: secondaryColor),),
                ],
              ),
              Text(
                "Let's get you a career now!",
                style: TextStyle(fontSize: text_md, fontWeight: medium),),

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

              const SizedBox(height: 40,),

              // random jobs
              Text(
                "Jobs you might like",
                style: TextStyle(fontSize: text_md, fontWeight: bold),),

              const SizedBox(height: 20,),


              FutureBuilder(
                  future: FireStoreService.getAllWithField('jobs'),
                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.done) {

                      if(!snapshot.hasData) {
                        const Center(child: Text('No Jobs are currently available.'));
                      }

                      final job = snapshot.data;

                      return SizedBox(
                        width: 1000,
                        height: 220,
                        child: ListView.separated(
                          separatorBuilder: (_, index) => const SizedBox(width: 10,),
                          scrollDirection: Axis.horizontal,

                          itemCount: job!.length,
                          itemBuilder: (context, index) {
                            return ColoredJobCard(
                              // jobID: job[index]['id'],
                              color: generateColor(),
                              imagePath: Supabase.instance.client.storage.from('file_uploads')
                                  .getPublicUrl(job[index]['imagePath']),
                              companyName: job[index]['companyName'],
                              address: job[index]['city'],
                              jobTitle: job[index]['jobTitle'],
                              jobType: job[index]['jobType'],
                              experience: job[index]['experience'],
                              minSalary: job[index]['minSalary'],
                              maxSalary: job[index]['maxSalary'],
                              date: job[index]['date'],
                              onPress: () => context.go('/home/job_view/${job[index]['id']}'),
                            );
                          },
                        ),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  }
              ),

              const SizedBox(height: 40,),

              // popular jobs
              Text(
                "Popular Jobs",
                style: TextStyle(fontSize: text_md, fontWeight: bold),),

              const SizedBox(height: 20,),

              FutureBuilder(
                  future: FireStoreService.getAllWithField('jobs'),
                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.done) {
                      
                      final jobs = snapshot.data;

                      return Column(
                        children: List.generate(jobs!.length, (idx) {
                          return Column(
                            children: [
                              JobCardList(
                                  imagePath: Supabase.instance.client.storage.from('file_uploads')
                                .getPublicUrl(jobs[idx]['imagePath']),
                                  jobTitle: jobs[idx]['jobTitle'],
                                  companyName: jobs[idx]['companyName'],
                                  maxSalary: jobs[idx]['maxSalary'],
                                  city: jobs[idx]['city'],
                                  jobType: jobs[idx]['jobType'],
                                  date: jobs[idx]['date'],
                                  onPress: () => context.go('/home/job_view/${jobs[idx]['id']}'),
                              ),

                              const SizedBox(height: 10,)
                            ],
                          );
                        })
                      );
                    }

                    return const Center(child: Text('No Jobs are currently available.'));
                  }
              ),

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}


