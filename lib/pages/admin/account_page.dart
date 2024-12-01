import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/globals/style.dart';
import 'package:flutter/material.dart';

class AdminAccountPage extends StatelessWidget {
  const AdminAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account", style: headerStyle),
        backgroundColor: Colors.transparent,
      ),

      body: Container(
        padding: horizontal,

        child: Column(
          children: [
            const SizedBox(height: 30,),

            Container(
              width: double.infinity,
              padding: cardPadding,
              decoration: BoxDecoration(
                color: light,
                borderRadius: border,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // admin's icon avatar
                  Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle
                        ),
                      ),

                      const Icon(Icons.person_rounded, size: 50, ),
                    ],
                  ),

                  // const SizedBox(width: 20,),

                  //name and email
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ADMIN",
                          style: TextStyle(fontSize: 18,  fontWeight: bold),
                        ),

                        const Text(
                          "admin@gmail.com",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                 IconButton(
                     onPressed: ()  {},
                     icon: const Icon(Icons.edit_square)
                 ),
                ],
              ),
            ),

            const SizedBox(height: 24,),

            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Button(
                  content: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 16,
                        color: light,
                        fontWeight: bold
                    ),
                  ),
                  color: red,
                  onPressed: (){}
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
