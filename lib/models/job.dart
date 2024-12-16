import 'package:dole_jobhunt/globals/data.dart';
import 'package:jiffy/jiffy.dart';

class Job {
  String? id;
  String? ownerID;
  String? imagePath;
  String companyName;
  String? purok;
  String?  baranggay;
  String? city;
  String jobTitle;
  double minSalary;
  double maxSalary;
  int experience;
  String jobType;
  String jobSummary;
  List<String> requirements;
  String category;
  String? timeUpdated = Jiffy.now().format().toString();
  List<String>? applicants = [];

  Job({
    this.id,
    this.ownerID,
    this.purok,
    this.baranggay,
    this.city,
    this.imagePath,
    required this.companyName,
    required this.jobTitle,
    required this.minSalary,
    required this.maxSalary,
    required this.experience,
    required this.jobType,
    required this.jobSummary,
    required this.requirements,
    required this.category,
    this.applicants,
    this.timeUpdated
  });

  toJSON() {
    return {
      "owner_id": ownerID,
      "image_path": imagePath,
      "company_name": companyName,
      "purok": purok,
      "baranggay": baranggay,
      "city": city,
      "job_category": category,
      "job_title": jobTitle,
      "min_salary": minSalary,
      "max_salary": maxSalary,
      "experience": experience,
      "job_type": jobType,
      "job_description": jobSummary,
      "requirements": requirements,
      "job_posted": timeUpdated,
      "applicants": applicants = []
    };
  }
}