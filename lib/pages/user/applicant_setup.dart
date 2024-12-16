import 'package:dole_jobhunt/components/inputs.dart';
import 'package:dole_jobhunt/globals/data.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../components/buttons.dart';
import '../../globals/style.dart';
import '../../services/firestore_service.dart';
import '../check_role.dart';

enum Gender { male, female }

class ApplicantSetupPage extends StatefulWidget {
  const ApplicantSetupPage({super.key, required this.uid});

  final String? uid;


  @override
  State<ApplicantSetupPage> createState() => _ApplicantSetupPageState();
}

class _ApplicantSetupPageState extends State<ApplicantSetupPage> {

  Gender? _gender = Gender.male;
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController prkCtrl = TextEditingController();
  TextEditingController brgyCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();

  File? _imageFile;

  // test only
  // void _getImage() async {
  //   final imageFile = Supabase.instance.client.storage.from('file_uploads').getPublicUrl('images/1734249125188');
  //
  //   print(imageFile);
  // }

  // save data to db
  void _saveData() async {

    print(contactCtrl.text);
    print(_gender?.name);

    // save image to supabase
    if(_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar((const SnackBar(content: Text('failed to upload'),)));
      return;
    };

    // generate unique filename
    final filename = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'images/$filename';

    await Supabase.instance.client.storage
        .from('file_uploads')
        .upload(path, _imageFile!)
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar((const SnackBar(content: Text('upload Successful'))));
        });


    // save data to firebase

    Map<String, dynamic> additionalData = {
      'profile_path': path,
      'contact': contactCtrl.text,
      'gender': _gender?.name,
      'purok': prkCtrl.text,
      'baranggay': brgyCtrl.text,
      'city': cityCtrl.text,
    };

    await FireStoreService.update('users', DataStorage.uid, additionalData);

    // route to Profile
    context.go('/profile');
  }

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

                Text('Set up your profile now', style: TextStyle(fontSize: text_h5, fontWeight: bold),),

                const SizedBox(height: 40,),

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

                const SizedBox(height: 40,),

                // fields
                // contact
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

                const SizedBox(height: 20,),

                // gender (radio)
                Row(
                  children: [
                    Radio<Gender>(
                      groupValue: _gender,
                      value: Gender.male,
                      fillColor: WidgetStatePropertyAll(secondaryColor),

                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),

                    Text('Male', style: TextStyle(fontSize: text_lg, fontWeight: medium),),

                    Radio<Gender>(
                      groupValue: _gender,
                      value: Gender.female,
                      fillColor: WidgetStatePropertyAll(secondaryColor),

                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),

                    Text('Female', style: TextStyle(fontSize: text_lg, fontWeight: medium),),
                  ],
                ),

                const SizedBox(height: 60,),

                // action buttons
                Row(
                  children: [
                    // back to role selection
                    Expanded(
                      child: Button(
                          content: const Text('Cancel'),
                          color: light,
                          onPressed: (){

                            // update role to none
                            FireStoreService.update('users', widget.uid!, {'role': ''});

                            Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const CheckRolePage(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = 0.0;
                                      const end = 5.0;
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

                    // proceed to applicant profile
                    Expanded(
                      child: Button(
                          content: Text('Find Career Now!',style: TextStyle(color: light),),
                          color: secondaryColor,
                          onPressed: _saveData
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}