import 'dart:async';

import 'package:flutter_complete_guide/DatabaseHandler/DbHelper.dart';
//import 'package:sqflite/sqflite.dart';

import '../models/isBool_model.dart';

final dbProvider = DbHelper.instance;

createLocation(IsBool isBool) async {
  final db = await (dbProvider.database);
  db.insert('IsBool', isBool.toMap());
}

Future<List<IsBool>> getAllLocations() async {
  final db = await (dbProvider.database);
  List<Map<String, dynamic>> allRows = await db.query('Location');
  List<IsBool> isBool = allRows
      .map((location) => IsBool.fromMap(IsBool, null))
      .toList(); //not sure if right (IsBool, null) or (IsBool, ?)
  return isBool;
}
