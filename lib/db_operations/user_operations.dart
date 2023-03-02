import 'dart:async';

import '../models/UserModel.dart';
import 'package:sqflite/sqflite.dart';

import '../DatabaseHandler/DbHelper.dart';

late Database _db;

class UserOperations {
  UserOperations? userOperations;

  final dbProvider = DbHelper.instance;

  createUser(UserModel user) async {
    final db = await (dbProvider.database);
    db.insert('User', user.toMap());
  }

  // Future<List<UserModel>> getAllUsers() async {
  //   final db = await (dbProvider.database as FutureOr<Database>);
  //   List<Map<String, dynamic>> UserModel = await db.query('User');
  //   List<UserModel> user = UserModel.fromMap((user) => UserModel.fromMap(UserModel)).toList();
  //   return user;
  // }

  saveData(UserModel user) async {
    var dbClient = await _db;
    var res = await dbClient.insert(user as String, user.toMap());
    return res;
  }

  Future<UserModel> readUser(int userId) async {
    final db = await (dbProvider.database);

    final maps = await db.query(
      userTable,
      columns: UserNotes.values,
      where: '${UserNotes} = ?',
      whereArgs: ['UserId'],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      throw Exception('User not found');
    }
  }
}
