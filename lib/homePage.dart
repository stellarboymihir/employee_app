import 'package:employee_app/FakeInfoProvider.dart';
import 'package:employee_app/services/databaseHelper.dart';
import 'package:flutter/material.dart';

import 'modal/employeeModal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  Access DatabaseHelper within anywhere in application.
  //  I will have an access to database

  String? _task = null;
  Employee? employeeModal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
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
          Center(
            child: InkWell(
              onTap: () async {
                DatabaseHelper().initDatabase();
                DatabaseHelper().insertSampleData();
              },

              // if (employeeModal != null) {
              //   await _databaseHelper
              //       .insertModal(employeeModal as EmployeeModal);
              // }

              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.green,
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to add data?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Employee Data will be added'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
