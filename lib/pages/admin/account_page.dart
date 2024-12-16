import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/globals/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../globals/data.dart';
import '../../services/auth.dart';

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // admin's icon avatar
                  Stack(
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage: (DataStorage.imagePath == null)
                              ? const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                              : NetworkImage(Supabase.instance.client.storage.from('file_uploads').getPublicUrl(DataStorage.imagePath))
                      ),
                    ],
                  ),

                  const SizedBox(width: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextStyle(fontSize: 18,  fontWeight: bold),
                      ),

                      Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),

                 const Spacer(),

                 IconButton(
                     onPressed: () => context.go('/admin_page/edit_profile'),
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
                    onPressed: () {
                      Auth.signOut();
                      context.go('/');
                    }
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
