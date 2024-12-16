import 'package:dole_jobhunt/components/label.dart';
import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class ColoredJobCard extends StatefulWidget {
  const ColoredJobCard({
    super.key,
    // required this.jobID,
    required this.color,
    required this.imagePath,
    required this.companyName,
    required this.address,
    required this.jobTitle,
    required this.jobType,
    required this.experience,
    required this.minSalary,
    required this.maxSalary,
    required this.date,
    this.onPress
  });

  // final String jobID;
  final Color color;
  final String imagePath;
  final String companyName;
  final String address;
  final String jobTitle;
  final String jobType;
  final int experience;
  final double minSalary;
  final double maxSalary;
  final String date;

  final VoidCallback? onPress;

  @override
  State<ColoredJobCard> createState() => _ColoredJobCardState();
}

class _ColoredJobCardState extends State<ColoredJobCard> {

  // get day history {Today, Yesterday, 3 day ago}
  String getDayHistory(int day) {

    if(day == 0) return 'Today';
    if(day == 1) return 'Yesterday';

    return '$day days ago';
  }

  @override
  Widget build(BuildContext context) {

    Jiffy datePosted = Jiffy.parse(widget.date);
    final diffInDays =  Jiffy.now().diff(datePosted, unit: Unit.day);

    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: borderM
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start
          ,
          children: [
            // image and companyname
            Row(
              children: [
                //image
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.imagePath),
                ),

                const SizedBox(width: 10,),

                //company name and location
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.companyName, style: TextStyle(
                        fontSize: text_md, color: light, fontWeight: semibold),
                    ),

                    Text(widget.address, style: TextStyle(
                        fontSize: text_xs, color: light),
                    )
                  ],
                )
              ],
            ),

            const SizedBox(height: 20,),

            // job title
            Text(widget.jobTitle, style: TextStyle(
                fontSize: text_xl, color: light, fontWeight: semibold),
            ),

            const SizedBox(height: 20,),

            // job type and experience
            Row(
              children: [
                Label(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    borderRadius: borderL,
                    icon: Icon(Icons.schedule_rounded, color: light, size: 16,),
                    title: widget.jobType,
                    textStyle: TextStyle(fontSize: 12, color: light),
                ),

                const SizedBox(width: 10,),

                Label(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    borderRadius: borderL,
                    icon: Icon(Icons.work_outline_rounded, color: light, size: 16,),
                    title: (widget.experience > 0)
                        ? '${widget.experience}+ years'
                        : 'Fresher',
                    textStyle: TextStyle(fontSize: 12, color: light),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            // salary and job posted
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₱ ${widget.minSalary} - ${widget.maxSalary}',
                  style: TextStyle(
                      color: light,
                      fontSize: text_md,
                      fontFamily: 'Roboto',
                      fontWeight: bold
                  ),),

                Label(
                    borderRadius: borderL,
                    bgColor: light,
                    icon: const Icon(Icons.history_rounded, size: 16,),
                    title: getDayHistory(diffInDays as int),
                    textStyle: TextStyle(color: dark, fontSize: 10),
                )
              ],
            )
          ],

        ),
      ),
    );
  }
}
