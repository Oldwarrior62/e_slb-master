import 'dart:async';

import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
//import 'package:sqflite/sqflite.dart';

import '../models/company_model.dart';

class CompanyOperations {
  CompanyOperations? companyOperations;

  final dbProvider = DbHelper.instance;

  createCompany(Company company) async {
    final db = await (dbProvider.database);
    db.insert('Company', company.toMap());
  }

  Future<List<Company>> getAllCompanys() async {
    final db = await (dbProvider.database);
    List<Map<String, dynamic>> allRows = await db.query('Company');
    List<Company> company =
        allRows.map((user) => Company.fromMap(Company)).toList();
    return company;
  }

  Future<Company> readCompany(int companyId) async {
    final db = await (dbProvider.database);

    final maps = await db.query(
      companyTable,
      columns: CompanyNotes.values,
      where: '${CompanyNotes} = ?',
      whereArgs: [companyId],
    );
    if (maps.isNotEmpty) {
      return Company.fromMap(maps.first);
    } else {
      throw Exception('Id not found');
    }
  }
}
