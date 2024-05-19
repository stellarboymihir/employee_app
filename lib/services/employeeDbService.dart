import 'dart:math';
import 'package:employee_app/services/databaseHelper.dart';
import '../FakeInfoProvider.dart';
import '../modal/employeeModal.dart';

class EmployeeDbService {
  static String tableName = "employeeTable";
  final DatabaseHelper _helperDb = DatabaseHelper.shared;

  Future<void> insert(Employee employee) async {
    Random random = Random();
    final db = await _helperDb.database;
    EmployeeModal modal = EmployeeModal(
        number: null,
        companyName: "GL",
        jobTitle: employee.jobTitle,
        experience: random.nextInt(10) + 1,
        name: employee.name);
    await db.insert(tableName, modal.toMap());
    print("Employee inserted successfully!");
  }

  Future<List<EmployeeModal>> read() async {
    final db = await _helperDb.database;
    List<Map<String, dynamic>> data = await db.query(tableName);
    print('Data retrieved: $data');
    List<EmployeeModal> employees = [];
    for (final row in data) {
      employees.add(EmployeeModal.fromMap(row));
    }
    return employees;
  }

  Future<void> delete(EmployeeModal employeeModal) async {
    final db = await _helperDb.database;
    final data = await db
        .delete(tableName, where: 'id = ?', whereArgs: [employeeModal.id]);
    print("Employee deleted successfully!");
  }
}
