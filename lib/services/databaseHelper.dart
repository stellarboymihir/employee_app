import 'package:employee_app/modal/employeeModal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //  Make this a singleton class
  // static final DatabaseHelper instance = DatabaseHelper.instance;
  // DatabaseHelper._constructor();
  final String _tableName = "employee";
  Database? _db;

  //  User exists in db or not
  Future<Database> get database async {
    if (_db != null) {
      print('Database exists!');
      return _db!;
    } else {
      print('Database not found');
    }
    _db = await initDatabase();
    return _db!;
  }

//  For opening database
  Future<Database?> initDatabase() async {
    final databasesDirPath = await getDatabasesPath();
    final databasePath = join(databasesDirPath, "employee.db");
    try {
      final database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: (db, version) {
          db.execute(
            """
         CREATE TABLE $_tableName (
	       "id"	INTEGER PRIMARY KEY,
	       "name"	TEXT,
	       "number"	INTEGER UNIQUE,
       	 "companyName"	TEXT,
      	 "jobTitle"	TEXT,
       	 "experience"	INTEGER NOT NULL,
         );
          """,
          );
        },
      );
      // print("Database is created sucessfully");
      return database;
    } catch (e) {
      print(databasePath);
      print("Error creating database: $e");
      return null;
    }
  }

  Future<void> insert(EmployeeModal employeeModal) async {
    final db = await database;
    await db.insert(_tableName, employeeModal.toMap());
    try {
      await _db?.insert(_tableName, employeeModal.toMap());
      print("Employee inserted successfully!");
    } catch (e) {
      print("Error Inserting employee: $e");
    }
  }

  // Future<void> read(EmployeeModal employeeModal) async {
  //   final db = await database;
  //   final data = await db.query(
  //     _tableName,
  //     where: 'id = ?',
  //     whereArgs: [employeeModal.id],
  //   );
  //
  //   print(data);
  // }
  Future<List<EmployeeModal>> read() async {
    final db = await database;
    List<Map<String, dynamic>> data = await db.query(_tableName);

    List<EmployeeModal> e = [];
    for (int i = 0; i < data.length; i++) {
      e.add(EmployeeModal.fromMap(data[i]));
    }
    return e;
    print(data);
  }

  Future<void> update(EmployeeModal employeeModal) async {
    final db = await database;
    final data = await db.update(
      _tableName,
      employeeModal.toMap(),
      where: 'id = ?',
      whereArgs: [employeeModal.id],
    );
    print(data);
    print("Employee updated successfully");
  }

  Future<void> delete(EmployeeModal employeeModal) async {
    final db = await database;
    final data = await db
        .delete(_tableName, where: 'id = ?', whereArgs: [employeeModal.id]);
    print("Employee deleted successfully!");
    print(data);
  }

  Future<void> insertSampleData() async {
    final db = await database;
    final employee = EmployeeModal(
      id: 1,
      name: 'John Doe',
      number: 1234567890,
      companyName: 'ABC Inc.',
      jobTitle: 'Software Engineer',
      experience: 5,
    );
    await db.insert(_tableName, employee.toMap());
    print("Sample employee inserted successfully!");
  }
}
