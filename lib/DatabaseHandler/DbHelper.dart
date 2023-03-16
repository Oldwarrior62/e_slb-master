import 'package:flutter_complete_guide/Bloc/Notes/notesState.dart';
import 'package:flutter_complete_guide/models/UserModel.dart';
import 'package:flutter_complete_guide/models/company_model.dart';
import 'package:flutter_complete_guide/models/daily_report_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _database;
  DbHelper._privateConstructor();

  static DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async {
    _database ??= await initializeDatabase();

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String dbpath = await getDatabasesPath();
    dbpath = "$dbpath/mydb.db";
    var stddb = await openDatabase(dbpath, version: 2, onCreate: _createdb);
    return stddb;
  }

  void _createdb(Database db, int newversion) async {
    // creations of tables
    await db.execute('''
CREATE TABLE dailyReport(
  dailyReportId INTEGER PRIMARY KEY AUTOINCREMENT,
  logs TEXT,
  dateCreated TEXT,
  notes TEXT,
  signature TEXT
)
''');
    await db.execute('''
CREATE TABLE user(
  name TEXT,
  surname TEXT,  
  email TEXT,
  password TEXT,
  image TEXT,
  securityLicenseExpiryDate TEXT,
  ofaExpiryDate TEXT,
  ofaLevel Text
)
''');
    await db.execute('''
CREATE TABLE isBool(
 isDyslexic BOOLEAN,
 isTwentyFour BOOLEAN,
 isDarkMode BOOLEAN
)
''');
    await db.execute('''
CREATE TABLE company(
 companyId INTEGER  PRIMARY KEY AUTOINCREMENT, 
 comapnyName TEXT,
 companyEmail Text,
 image Text
)

''');
  }
  //-----------------------------------------------------------------//

  Future<int?> saveData(UserModel user) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> templst = await db.query('user');
    for (var val in templst) {
      UserModel userModel = UserModel.fromMap(val);
      if (userModel.surname == user.surname &&
          userModel.password == user.password) {
        return -1;
      }
    }
    int result = await db.insert('user', user.toMap());
    return result;
  }

  Future<int?> updateUserData(UserModel user) async {
    Database db = await instance.database;
    int result = await db.update('user', user.toMap(),
        where: "surname=?", whereArgs: [user.surname]);

    return result;
  }

  Future<UserModel?> getLoginUser(String surname, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> templst = await db.query('user');
    for (var user in templst) {
      UserModel userModel = UserModel.fromMap(user);
      if (userModel.surname == surname && userModel.password == password) {
        return userModel;
      }
    }

    return null;
  }

  Future<int?> insertCompanyData(Company company) async {
    Database db = await instance.database;
    int result = await db.insert('company', company.toMap());
    return result;
  }

  Future<List<Company>> getAllCompany() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db.query('company');
    List<Company> allCompanies = [];
    for (var company in allRows) {
      Company c = Company.fromMap(company);
      if (c.companyName != null) {
        allCompanies.add(c);
      }
    }
    return allCompanies;
  }

  Future<int?> insertDailyReport(DailyReportNotes dailyReport) async {
    Database db = await instance.database;
    int result = await db.insert('dailyReport', dailyReport.toMap());
    return result;
  }

  Future<int?> updateDailyReportNotes(DailyReportNotes dailyReport) async {
    Database db = await instance.database;
    int result = await db.update('dailyReport', dailyReport.toMap(),
        where: "dailyReportId=?", whereArgs: [dailyReport.dailyReportId]);
    return result;
  }

  Future<List<DailyReportNotes>> getAllReports() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db.query('dailyReport');
    List<DailyReportNotes> allDailyReport = allRows
        .map((dailyReport) => DailyReportNotes.fromJson(dailyReport))
        .toList();

    return allDailyReport;
  }

  Future<int?> deleteDailyReport(int id) async {
    Database db = await instance.database;
    int result = await db
        .delete('dailyReport', where: 'dailyReportId=?', whereArgs: [id]);
    return result;
  }

  Future<int?> insertNotes(Notes notes) async {
    Database db = await instance.database;
    int result = await db.insert('notes', notes.toMap());
    return result;
  }

  Future<int?> updateNotes(Notes notes) async {
    Database db = await instance.database;
    int result = await db.update('notes', notes.toMap(),
        where: 'date=?', whereArgs: [notes.date]);

    return result;
  }

  Future<DailyReportNotes?> checkNotes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db.query('dailyReport');
    List<DailyReportNotes> allNotes =
        allRows.map((notes) => DailyReportNotes.fromJson(notes)).toList();
    DailyReportNotes? notes;
    allNotes.removeWhere((element) => element.dailyReportId == null);
    if (allNotes.length > 0) {
      DateTime dt1 = DateTime.parse(
          "${allNotes.last.dateCreated!.split(' ')[0]} 00:00:00");
      DateTime dt2 =
          DateTime.parse("${DateTime.now().toString().split(' ')[0]} 00:00:00");
      if (dt2.isAfter(dt1)) {
      } else if (dt2.isAtSameMomentAs(dt1)) {
        notes = allNotes.last;
      }
    }
    return notes;
  }

  Future<List<DailyReportNotes>> getDailyReports() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db.query('dailyReport');
    List<DailyReportNotes> allNotes =
        allRows.map((notes) => DailyReportNotes.fromJson(notes)).toList();
    return allNotes;
  }
}
