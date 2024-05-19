import 'package:employee_app/FakeInfoProvider.dart';
import 'package:employee_app/services/databaseHelper.dart';
import 'package:employee_app/services/employeeDbService.dart';
import 'package:flutter/material.dart';

import 'modal/employeeModal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  Access DatabaseHelper
  final _employeeService = EmployeeDbService();
  //  List to store employee
  List<EmployeeModal> _employees = [];
  final TextEditingController _nameController = TextEditingController();

  Future<void> _getEmployees() async {
    print('employee class is getting initiated ********');
    _employees = (await _employeeService.read())
        .cast<EmployeeModal>(); // Read data from database
    setState(() {});
  }

  //
  Future<void> _addEmployee() async {
    final Employee fakeEmployee = FakeInfoProvider.getFakeEmployee();
    await _employeeService.insert(fakeEmployee); // Insert into DB
    // return;
  }
  // print('Employee is not empty');
  // EmployeeModal employee = EmployeeModal(name: name);
  //
  //   _faker.detailEmployee();
  //   await _employeeService.insert(employee as Employee); // Insert into DB
  //   await _getEmployees(); // Refresh employee list
  //   _nameController.text = ''; // Clear text field after adding
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('||||||||||||||||||||         getting employe ');
    _addEmployee();
    _getEmployees(); // Get employees on app start
  }

  Color _getColor(int? experience) {
    return experience! >= 5 ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showMyDialog, // Call _addEmployee on tap
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _employees.length,
            itemBuilder: (BuildContext context, int index) {
              final employee = _employees[index];
              return Column(
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _getColor(employee.experience),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(employee.name!), // Access name from Employee Modal
                        Text(employee.experience
                            .toString()), // Access experience
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
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
                Text('Employee "${_nameController.text}" will be added'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Refresh'),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                print('button is tapped');
                _addEmployee();
                _getEmployees();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// InkWell(
// onTap: () {
// Employee employee = FakeInfoProvider.getFakeEmployee();
// employee.detailEmployee();
//
// EmployeeDbService service = EmployeeDbService();
//
// // service.onCreate();
//  service.insert(employee);
// },
// child: Container(
// height: 100,
// width: 200,
// color: Colors.yellowAccent,
// ),
// ),
//
