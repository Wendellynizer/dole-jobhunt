import 'package:dole_jobhunt/components/label.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../globals/style.dart';

class JobCardList extends StatefulWidget {
  const JobCardList({
    super.key,
    required this.imagePath,
    required this.jobTitle,
    required this.companyName,
    required this.maxSalary,
    required this.city,
    required this.jobType,
    required this.date,
    this.onPress
  });

  final String imagePath;
  final String jobTitle;
  final String companyName;
  final String city;
  final double maxSalary;
  final String jobType;
  final String date;
  final VoidCallback? onPress;

  @override
  State<JobCardList> createState() => _JobCardListState();
}

class _JobCardListState extends State<JobCardList> {

  String getDayHistory(int day) {

    if(day == 0) return 'today';

    return '${day}d';
  }

  @override
  Widget build(BuildContext context) {

    Jiffy datePosted = Jiffy.parse(widget.date);
    final diffInDays =  Jiffy.now().diff(datePosted, unit: Unit.day);

    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: light,
          borderRadius: borderM
        ),

        child:  Column(
          children: [
            Row(
              children: [
                // logo
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.imagePath),
                ),

                const SizedBox(width: 10,),

                // company and address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.jobTitle, style: TextStyle(fontSize: text_md, fontWeight: bold),),
                    const SizedBox(height: 5,),
                    Text(widget.companyName, style: TextStyle(color: dark50, fontSize: text_xs),),
                  ],
                ),

              ],
            ),

            const SizedBox(height: 20,),

            Row(
              children: [
                Label(
                    borderRadius: borderL,
                    bgColor: Color(0x11000000),
                    textStyle: TextStyle(color: dark50, fontWeight: semibold, fontSize: text_xs),
                    icon: Icon(Icons.location_on_outlined, color: dark50, size: 16,),
                    title: widget.city,
                ),

                const SizedBox(width: 10,),

                Label(
                  borderRadius: borderL,
                  bgColor: Color(0x11000000),
                  textStyle: TextStyle(color: dark50, fontWeight: semibold, fontSize: text_xs),
                  icon: Icon(Icons.work_outline_rounded, color: dark50, size: 16,),
                  title: widget.jobType,
                )
              ],
            ),

            const SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₱ ${widget.maxSalary}/m',
                  style: TextStyle(
                      fontSize: text_md,
                      fontFamily: 'Roboto',
                      fontWeight: bold
                  ),
                ),

                Text(
                  getDayHistory(diffInDays as int),
                  style: TextStyle(
                      fontSize: text_md,
                      fontFamily: 'Roboto',
                      fontWeight: bold
                  ),
                ),
              ],
            ),
          ],


        ),
      ),
    );
  }
}
