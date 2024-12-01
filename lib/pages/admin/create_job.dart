import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';

import '../../globals/style.dart';

class CreateJobPage extends StatefulWidget {
  const CreateJobPage({super.key});

  @override
  State<CreateJobPage> createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {

  int _currentStep = 0;

  void _onStepContinue() {
    setState(() {
      if(_currentStep < _steps().length - 1) _currentStep++;
    });
  }

  void _onStepBack() {
    setState(() {
      if(_currentStep > 0) _currentStep--;
    });
  }

  List<RequirementField> _requirementFields = [];

  List<EasyStep> _steps() => [
    EasyStep(
      customStep: CircleAvatar(
        radius: 20,
        backgroundColor: light,
        child: Icon(Icons.work_rounded),
      ),
    ),

    EasyStep(
      customStep: CircleAvatar(
        radius: 20,
        backgroundColor: light,
        child: Icon(Icons.info_rounded),
      ),
    )
  ];

  // controls the widget the body is showing
  Widget _bodyBuilder(int step) {
    switch(step) {
      case 1:
        return _jobDescription();
    }

    return _jobDetails();
  }

  // job details widget
  Widget _jobDetails() {
    return Padding(
      padding: horizontal,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Details', style: TextStyle(
            fontSize: text_h5,
            fontWeight: bold
          ),),

          const SizedBox(height: 20,),

        // position name
          TextInput(hintText: "Position"),

          const SizedBox(height: 15,),

          // salary
          NumberInput(hintText: "Min salary",),

          const SizedBox(height: 15,),

          NumberInput(hintText: "Max salary",),

          const SizedBox(height: 15,),

          // job type dropdown
          const DropdownInput(
            hintText: 'Job Type',
            options: const [
            DropdownMenuEntry<String>(value: "full time", label: "Full Time"),
            DropdownMenuEntry<String>(value: "part time", label: "Part Time")
            ]
          )
        ],
      )
    );
  }

  // job description widget
  Widget _jobDescription() {
    return Padding(
        padding: horizontal,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Job Description', style: TextStyle(
                fontSize: text_h5,
                fontWeight: bold
            ),),

            const SizedBox(height: 20,),

            // job summary text area
            TextArea(hintText: "Job Summary", maxLines: 10,),

            const SizedBox(height: 30,),

            // job requirements
            Text('Job Requirements', style: TextStyle(fontWeight: semibold),),

            const SizedBox(height: 20,),

            Column(
              children: _requirementFields
            ),

            // prototype
            Button(
                content: Icon(Icons.add_rounded, color: light,),
                color: secondaryColor,
                onPressed: (){},
            )
          ]
        )
    );
  }

  // action buttons
  Widget _actionButtons() {
    return Padding(
      padding: horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Button(
              content: Text('Back', style: TextStyle(fontSize: text_lg),),
              color: Color(0x000000).withOpacity(0.1),
              borderRadius: borderSM,
              onPressed: _onStepBack
          ),

          const SizedBox(width: 15,),

          Button(
              content: Text('Next', style: TextStyle(fontSize: text_lg, color: light),),
              color: secondaryColor,
              borderRadius: borderSM,
              onPressed: _onStepContinue
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Job", style: headerStyle),
        backgroundColor: primaryColor,
      ),

      body: Column(
        children: [
          EasyStepper(
              activeStep: _currentStep,
              showLoadingAnimation: false,
              stepRadius: 20,
              // lineStyle: LineStyle(
              //     lineType: LineType.normal
              // ),


              steps: _steps()
          ),

          Expanded(
            child: ListView(
              children: [
                _bodyBuilder(_currentStep),
              ],
            )

          ),

          _actionButtons(),

          const SizedBox(height: 20,)
        ],
      )
    );
  }
}


class RequirementField extends StatefulWidget {

  const RequirementField({
    super.key,
    this.text,
    required this.onTappedOut,
    required this.controller
  });

  final String? text;
  final VoidCallback onTappedOut;
  final TextEditingController controller;

  @override
  State<RequirementField> createState() => _RequirementFieldState();
}

class _RequirementFieldState extends State<RequirementField> {


  @override
  Widget build(BuildContext context) {
    return TextInput(
        hintText: 'requirement',
    );
  }
}
