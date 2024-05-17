//  Define DataModal
import 'dart:ffi';

class EmployeeModal {
  int? id;
  String? name;
  int? number;
  String? companyName;
  String? jobTitle;
  int? experience;
  EmployeeModal(
      {this.id,
      this.name,
      this.number,
      this.companyName,
      this.jobTitle,
      this.experience});

  // Convert a Employee into a Map. The keys must correspond to
  // the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'experience': experience,
    };
  }

  //  Converting a Map into an instance of Employee Modal class
  EmployeeModal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    number = map['number'];
    companyName = map['companyName'];
    jobTitle = map['jobTitle'];
    experience = map['experience'];
  }
}
