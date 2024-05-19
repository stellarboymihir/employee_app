import 'package:faker/faker.dart';

class Employee {
  //  It will generate user

  var name;
  var number;
  var companyName;
  var jobTitle;
  var experience;

  void detailEmployee() {
    print("Name: $name");
    print("Number: $number");
    print("CompanyName: $companyName");
    print("Job Title:  $jobTitle");
    print("Experience: $experience");
  }
}

// It will generate fake information
class FakeInfoProvider {
  static getFakeEmployee() {
    Employee employee = Employee();

    var faker = Faker();
    employee.name = faker.person.name();
    employee.number = faker.phoneNumber.us();
    employee.companyName = faker.company.name();
    employee.jobTitle = faker.job.title();
    employee.experience =
        faker.date.dateTimeBetween(DateTime(2016), DateTime.now());

    // print(employee.name);
    // print(employee.number);
    // print(employee.companyName);
    // print(employee.jobTitle);
    // print(employee.experience);

    return employee;
  }
}
