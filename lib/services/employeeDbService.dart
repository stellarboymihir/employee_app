import 'dart:math';

import 'package:employee_app/services/databaseHelper.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../FakeInfoProvider.dart';
import '../modal/employeeModal.dart';

class EmployeeDbService {
  final String _tableName = "employeeTable";

  // final faker = FakeInfoProvider.getFakeEmployee(); // Generate Fake info

  static final DatabaseHelper helperDb = DatabaseHelper();

  Future<void> insert(Employee employee) async {
    Random random = Random();
    final db = await helperDb.database;
    EmployeeModal modal = EmployeeModal(
        number: null,
        companyName: "GL",
        jobTitle: employee.jobTitle,
        experience: random.nextInt(10) + 1,
        name: employee.name);
    await db.insert(_tableName, modal.toMap());
    print("Employee inserted successfully!");
  }

  // Future<void> tempInsert() async {
  //   final db = await DatabaseHelper().database;
  //   await db.insert(
  //     'employeeTable',
  //     EmployeeModal(
  //       id: 1,
  //       name: "MIHIR",
  //       experience: 1,
  //       jobTitle: "Developer",
  //       companyName: "JJThomas",
  //       number: 9325684921,
  //     ).toMap(),
  //   );
  // }

  Future<List<EmployeeModal>> read() async {
    final db = await helperDb.database;
    List<Map<String, dynamic>> data = await db.query(_tableName);
    print('Data retrieved: $data');
    List<EmployeeModal> employees = [];
    for (final row in data) {
      employees.add(EmployeeModal.fromMap(row));
    }
    return employees;
  }

  // Future<void> update(EmployeeModal employeeModal) async {
  //   final db = await DatabaseHelper().database;
  //   final data = await db.update(
  //     _tableName,
  //     faker,
  //     where: 'id = ?',
  //     whereArgs: [employeeModal.id],
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //
  //   print("Employee updated successfully");
  // }

  Future<void> delete(EmployeeModal employeeModal) async {
    final db = await helperDb.database;
    final data = await db
        .delete(_tableName, where: 'id = ?', whereArgs: [employeeModal.id]);
    print("Employee deleted successfully!");
  }
}
