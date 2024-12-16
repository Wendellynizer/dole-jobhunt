import 'package:dole_jobhunt/components/buttons.dart';
import 'package:dole_jobhunt/components/inputs.dart';
import 'package:dole_jobhunt/services/auth.dart';
import 'package:dole_jobhunt/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:jiffy/jiffy.dart';

import '../../globals/style.dart';
import '../../models/job.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({
    super.key,
    required this.job
  });

  final Job job;

  @override
  State<EditJobPage> createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<EditJobPage> {

  int _currentStep = 0;
  bool _isAddingReq = false;

  List<String> _requirements = [];

  // dropdown user data
  TextEditingController jobTitleCtrl = TextEditingController();
  TextEditingController minSalaryCtrl = TextEditingController();
  TextEditingController maxSalaryCtrl = TextEditingController();
  TextEditingController experienceCtrl = TextEditingController();
  TextEditingController jobSummaryCtrl = TextEditingController();
  TextEditingController reqController = TextEditingController();
  String jobCategory = '';
  String jobType = '';

  // action button
  String buttonText = 'Next';


  @override
  void initState() {
    super.initState();

    jobCategory = widget.job.category;
    jobTitleCtrl.text = widget.job.jobTitle;
    minSalaryCtrl.text = widget.job.minSalary.toString();
    maxSalaryCtrl.text = widget.job.maxSalary.toString();
    experienceCtrl.text = widget.job.experience.toString();
    jobType = widget.job.jobType;
    jobSummaryCtrl.text = widget.job.jobSummary;
    _requirements = widget.job.requirements;
  }


  List<EasyStep> _steps() => [
    EasyStep(
      customStep: CircleAvatar(
        radius: 20,
        backgroundColor: light,
        child: const Icon(Icons.work_rounded),
      ),
    ),

    EasyStep(
      customStep: CircleAvatar(
        radius: 20,
        backgroundColor: light,
        child: const Icon(Icons.info_rounded),
      ),
    )
  ];

  void _onStepContinue() {
    setState(() {
      if(_currentStep < _steps().length - 1) {
        _currentStep++;
      }

      buttonText = (_currentStep < _steps().length - 2)? 'Next' : 'Save';
    });
  }

  void _onStepBack() {
    setState(() {
      if(_currentStep > 0) _currentStep--;

      buttonText = (_currentStep < _steps().length - 1)? 'Next' : 'Save';
    });
  }

  void _toggleRequirementFieldState() {
    setState(() {
      _isAddingReq = !_isAddingReq;
      // reqController.clear();
    });
  }

  void _addRequirement(String text) {
    setState(() {
      if(reqController.text != '') {
        _requirements.add(text);
        reqController.clear();
      }
    });
  }

  void _removeRequirement(int idx) {
    setState(() {
      _requirements.removeAt(idx);
    });
  }



  // controls the widget the body is showing
  Widget _bodyBuilder(int step) {
    switch(step) {
      case 1:
        return _jobDescription();
    }

    return _jobDetails();
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
              content: Text(
                buttonText,
                style: TextStyle(fontSize: text_lg, color: light),
              ),
              color: secondaryColor,
              borderRadius: borderSM,
              onPressed: () {
                // execute save function of _current step is in last step
                if(_currentStep >= _steps().length - 1) {

                  FireStoreService.update(
                      'jobs',
                      widget.job.id!,
                      {
                        "job_category": jobCategory,
                        "job_title": jobTitleCtrl.text,
                        "min_salary": double.parse(minSalaryCtrl.text),
                        "max_salary": double.parse(maxSalaryCtrl.text),
                        "experience": int.parse(experienceCtrl.text),
                        "job_type": jobType,
                        "job_description": jobSummaryCtrl.text,
                        "requirements": _requirements,
                        "job_posted": Jiffy.now().format(),
                      }
                  );

                  // go back to job details page
                  Navigator.pop(context, true);
                }

                _onStepContinue();
              }
          ),
        ],
      ),
    );
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

            // job category dropdown
            DropdownInput(
              initialValue: jobCategory,
              hintText: 'Job Category',
              options: const [
                DropdownMenuEntry<String>(value: "Information Technology", label: "Information Technology"),
                DropdownMenuEntry<String>(value: "Digital Creator", label: "Digital Creator"),
              ],
              onSelected: (item) {
                jobCategory = item;
              },
            ),

            const SizedBox(height: 15,),

            // position name
            TextInput(hintText: "Job Title", controller: jobTitleCtrl,),

            const SizedBox(height: 15,),

            // salary
            NumberInput(hintText: "Min salary", controller: minSalaryCtrl),

            const SizedBox(height: 15,),

            NumberInput(hintText: "Max salary", controller: maxSalaryCtrl),

            const SizedBox(height: 15,),

            NumberInput(hintText: "No. of experience", controller: experienceCtrl),

            const SizedBox(height: 15,),

            // job type dropdown
            DropdownInput(
              hintText: 'Job Type',
              initialValue: jobType,
              options: const [
                DropdownMenuEntry<String>(value: "Full Time", label: "Full Time"),
                DropdownMenuEntry<String>(value: "Part Time", label: "Part Time")
              ],

              onSelected: (item) {
                jobType = item;
              },
            )
          ],
        )
    );
  }

  // job description widget
  Widget _jobDescription() {
    return Padding(
        padding: horizontal,

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Job Description', style: TextStyle(
                  fontSize: text_h5,
                  fontWeight: bold
              ),),

              const SizedBox(height: 20,),

              // job summary text area
              TextArea(hintText: "Job Summary", maxLines: 10, controller: jobSummaryCtrl),

              const SizedBox(height: 30,),

              // job requirements
              Text('Job Requirements', style: TextStyle(fontSize: text_lg, fontWeight: semibold),),

              const SizedBox(height: 20,),

              // shows/hide the requirement field and button
              _isAddingReq
                  ? Row(
                // requirement field
                children: [
                  Expanded(
                      child: TextInput(
                        hintText: "Enter requirement...",
                        controller: reqController,
                      )
                  ),

                  const SizedBox(width: 5,),

                  // action buttons
                  // add requirement button
                  IconButton(
                    onPressed: () => _addRequirement(reqController.text),
                    icon: Icon(Icons.check_rounded, color: secondaryColor,),

                  ),

                  // responsible for closing the requirement field
                  IconButton(
                    onPressed: _toggleRequirementFieldState,
                    icon: Icon(Icons.close_rounded, color: red,),

                  ),
                ],
              )

                  : Button(
                // responsible for showing the requirement field
                content: Icon(Icons.add_rounded, color: light,),
                color: secondaryColor,
                onPressed: _toggleRequirementFieldState,
              ),

              const SizedBox(height: 20,),

              // list of requirements
              Column(
                children: _requirements.asMap().entries.map((entry) {
                  int index = entry.key;
                  String value = entry.value;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: secondaryColor, size: 10,),

                          const SizedBox(width: 10),

                          // requirement list item title
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.63
                            ),

                            child: Text(
                              value,
                              style: TextStyle(fontSize: text_md, fontWeight: medium),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 5),

                      IconButton(
                        onPressed: () => _removeRequirement(index),
                        icon: Icon(Icons.delete_rounded, color: red),
                        padding: EdgeInsets.zero,
                      )
                    ],
                  );
                }).toList(),
              ),

              const SizedBox(height: 50,)
            ]
        )
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


              steps: _steps(),
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