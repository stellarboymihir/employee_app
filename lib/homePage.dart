import 'package:employee_app/FakeInfoProvider.dart';
import 'package:flutter/material.dart';

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
                Employee employee = FakeInfoProvider.getFakeEmployee();
                employee.detailEmployee();
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
}
