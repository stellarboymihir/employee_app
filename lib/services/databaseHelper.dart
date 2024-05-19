import 'package:employee_app/modal/employeeModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _db;
  static final DatabaseHelper helperDb = DatabaseHelper();

  DatabaseHelper() {
    WidgetsFlutterBinding.ensureInitialized();
    print('>>>>> Database contructor called');
  }

  //  User exists in db or not
  Future<Database> get database async {
    if (_db != null) {
      print('Database exists!');
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

//  For opening database
  Future<Database?> initDatabase() async {
    final databasesDirPath = await getDatabasesPath();
    final databasePath = join(databasesDirPath, "employee.db");

    _db = await openDatabase(databasePath, version: 1, onConfigure: (version) {
      print(">>>> DB configure called");
    }, onOpen: (vesion) {
      print(">>>> DB open called");
    }, onCreate: (db, version) {
      print(">>>> DB onCreate called");
      onCreate();
    });

    return database;
  }

  Future<void> onCreate() async {
    final db = await database;
    await db.execute("""
      CREATE TABLE IF NOT EXISTS ${EmployeeDbService._tableName} (
	    id INTEGER PRIMARY KEY,
	    name	TEXT NOT NULL,
	    number INTEGER,
	    companyName TEXT NOT NULL,
	    jobTitle TEXT NOT NULL,
	    experience INTEGER
      );
      """);
  }
}
