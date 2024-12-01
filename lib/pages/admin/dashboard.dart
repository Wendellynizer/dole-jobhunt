import 'package:dole_jobhunt/pages/admin/account_page.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../globals/style.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  String getDateToday() {
    return Jiffy.now().format(pattern: 'E, MMM d, y');
  }

  @override
  Widget build(BuildContext context) {
    getDateToday();

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: headerStyle),
        backgroundColor: Colors.transparent,
      ),
      
      body: Container(
        padding: horizontal,
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            // hello name
            Text(
              "Hello Admin!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: medium
              ),
            ),

            // date
            Text(
              getDateToday(),
              style: TextStyle(
                  color: dark50,
                  fontSize: 14,
              ),
            ),

            const SizedBox(height: 30,),

            // dashcards
            Flex(
              direction: Axis.horizontal,
              children: [


                // dashcards
                DashCard(
                  title: "Active Jobs",
                  icon: Icons.work_outline_rounded,
                  iconColor: Color(0xff6198FF),
                  count: 20,
                ),

                SizedBox(width: 14,),

                DashCard(
                  title: "Candidates",
                  icon: Icons.person_outline_rounded,
                  iconColor: Color(0xffFF6D6D),
                  count: 129,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DashCard extends StatelessWidget {

  final String title;
  final IconData icon;
  final Color? iconColor;
  final int count;

  const DashCard({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor,
    required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Expanded (
      child: Container(
        padding: cardPadding,

        decoration: BoxDecoration(
            color: light,
          borderRadius: border
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(
                    color: dark50,
                    fontSize: 14,
                    fontWeight: medium
                )),

                Icon(icon, color: iconColor,)
              ],
            ),

            const SizedBox(height: 8,),

            Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: bold
                )
            )
          ],
        ),
      ),
    );
  }
}
