import 'dart:io';

import 'package:dole_jobhunt/globals/data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/buttons.dart';
import '../../components/inputs.dart';
import '../../globals/style.dart';
import '../../services/firestore_service.dart';
import '../check_role.dart';
import 'admin_page.dart';

class CompanySetupPage extends StatefulWidget {
  const CompanySetupPage({super.key, required this.uid});

  final String? uid;

  @override
  State<CompanySetupPage> createState() => _CompanySetupPageState();
}

class _CompanySetupPageState extends State<CompanySetupPage> {

  final companyNameCtrl = TextEditingController();
  final companyEmailCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final prkCtrl = TextEditingController();
  final brgyCtrl = TextEditingController();
  final cityCtrl = TextEditingController();

  File? _imageFile;

  // choose image from file
  void _chooseImage() async {
    // picker
    final ImagePicker picker = ImagePicker();

    // pick from gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // update image preview
    if(image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  // adds additional fields to employer type user and save
  Future<void> _saveCompanyInfo() async {

    // prevent saving if profile is null
    if(_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar((const SnackBar(content: Text('Failed to Save'),)));
      return;
    }

    // generate unique filename
    final filename = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'images/$filename';

    // save image to supabase
    await Supabase.instance.client.storage
        .from('file_uploads')
        .upload(path, _imageFile!)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar((const SnackBar(content: Text('Save Successful'))));
    });

    companyNameCtrl.text = 'Chill Guy Inc.';
    companyEmailCtrl.text = 'chills@gmail.com';
    contactCtrl.text = '09514135319';
    prkCtrl.text = 'Purok 3B';
    brgyCtrl.text = 'Sto. Nino';
    cityCtrl.text = 'Carmen';

    DataStorage.imagePath = path;
    DataStorage.purok = prkCtrl.text;
    DataStorage.baranggay = brgyCtrl.text;
    DataStorage.city = cityCtrl.text;
    DataStorage.companyName = companyNameCtrl.text;

    await FireStoreService.update(
        'users',
        DataStorage.uid,
        {
          'image_path': path,
          'company_name': companyNameCtrl.text,
          'company_email': companyEmailCtrl.text,
          'contact': contactCtrl.text,
          'purok': prkCtrl.text,
          'baranggay': brgyCtrl.text,
          'city': cityCtrl.text,
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 26, right: 26,),

        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const SizedBox(height: 60,),

                Text('Set up your Company', style: TextStyle(fontSize: text_h5, fontWeight: bold),),

                const SizedBox(height: 20,),

                // image
                MaterialButton(
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(500))
                  ),
                  onPressed: _chooseImage,

                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: secondaryColor, width: 4)
                    ),

                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: (_imageFile == null)
                            ? const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                            : FileImage(_imageFile!, scale: 0.3)
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                TextInput(
                  hintText: 'Company Name',
                  controller: companyNameCtrl,
                ),

                const SizedBox(height: 10,),

                TextInput(
                  hintText: 'Company Email',
                  controller: companyEmailCtrl,
                ),

                const SizedBox(height: 10,),

                NumberInput(
                  hintText: 'Contact Number',
                  controller: contactCtrl,
                ),

                const SizedBox(height: 10,),

                TextInput(
                  hintText: 'Purok/Block/Street',
                  controller: prkCtrl,
                ),

                const SizedBox(height: 10,),

                TextInput(
                  hintText: 'Baranggay',
                  controller: brgyCtrl,
                ),

                const SizedBox(height: 10,),

                TextInput(
                  hintText: 'City',
                  controller: cityCtrl,
                ),

                const SizedBox(height: 50,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    // cancel button
                    Expanded(
                      child: Button(
                          content: const Text('Cancel', style: TextStyle(),),
                          color: light,
                          padding: buttonPadding,
                          onPressed: () {
                            // update role to none
                            FireStoreService.update('users', widget.uid!, {'role': ''});

                            // go back to role selection page
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const CheckRolePage(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = 0.0;
                                      const end = 3.0;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      var opacityAnimation = animation.drive(tween);

                                      return FadeTransition(
                                        opacity: opacityAnimation,
                                        child: child,
                                      );
                                    }
                                )
                            );
                          }
                      ),
                    ),

                    const SizedBox(width: 10,),

                    // create company button
                    Expanded(
                      child: Button(
                          content: Text('Start Hiring!', style: TextStyle(color: light),),
                          color: secondaryColor,
                          padding: buttonPadding,
                          onPressed: () async {
                            await _saveCompanyInfo();

                            // navigate to admin page
                            context.go('/admin_page');
                            // Navigator.of(context).push(
                            //     PageRouteBuilder(
                            //         pageBuilder: (context, animation, secondaryAnimation) => const AdminPage(),
                            //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            //           const begin = 0.0;
                            //           const end = 3.0;
                            //           const curve = Curves.easeInOut;
                            //
                            //           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            //           var opacityAnimation = animation.drive(tween);
                            //
                            //           return FadeTransition(
                            //             opacity: opacityAnimation,
                            //             child: child,
                            //           );
                            //         }
                            //     )
                            // );
                          }
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
