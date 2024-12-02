import 'package:jiffy/jiffy.dart';

class Job {
  String jobTitle;
  double minSalary;
  double maxSalary;
  int experience;
  String jobType;
  String jobSummary;
  List<String> requirements;
  String category;
  String timeUpdated = Jiffy.now().format().toString();
  int applicantCount = 0;

  Job({
    required this.jobTitle,
    required this.minSalary,
    required this.maxSalary,
    required this.experience,
    required this.jobType,
    required this.jobSummary,
    required this.requirements,
    required this.category
  });

  toJSON() {
    return {
      "job_category": category,
      "job_title": jobTitle,
      "min_salary": minSalary,
      "max_salary": maxSalary,
      "experience": experience,
      "job_type": jobType,
      "job_posted": timeUpdated,
      "application_count": applicantCount
    };
  }
}