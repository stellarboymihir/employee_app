import 'package:faker/src/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                faker();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                height: 100,
                width: 100,
                child: const Text('Click Here...!'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void faker() {
    var faker = new Faker();
    var name = faker.person.name();
    var number = faker.phoneNumber.us();
    var company_name = faker.company.name();
    var jobTitle = faker.job.title();
    var experience = faker.date
        .dateTimeBetween(DateTime(2000, 2, 13), DateTime(2024, 5, 15));

    print(name);
    print(number);

    print(company_name);
    print(jobTitle);
    print(experience);
  }
}
