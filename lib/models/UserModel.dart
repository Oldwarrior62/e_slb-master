//import 'dart:async';

//import 'package:sqflite/sqflite.dart';

final String userTable = 'user';
//late Database _db;

class UserNotes {
  static final List<String> values = [
    userId,
    name,
    surname,
    email,
    password,
  ];
  static final String userId = 'userId';
  static final String name = 'name';
  static final String surname = 'surname';
  static final String email = 'email';
  static final String password = 'password';
}

class UserModel {
  String? userId;
  String? name;
  String? surname;
  String? email;
  String? password;
  String? image;
  String? securityLicense;
  String? ofa;

  UserModel(
      {this.userId,
      this.name,
      this.surname,
      this.email,
      this.password,
      this.image,
      this.securityLicense,
      this.ofa});

  // Future<int> saveData(UserModel user) async {
  //   var dbClient = await _db;
  //   var res = await dbClient.insert(user as String, user.toMap());
  //   return res;
  // }

  // updateUser(UserModel user) async {
  //   final db = await (dbProvider.database as FutureOr<Database>);
  //   db.update('dailyReport', user.toMap(),
  //       where: 'userId=?', whereArgs: [UserModel.userId]);
  // }

  UserModel.fromMap(dynamic obj) {
    this.name = obj['name'];
    this.surname = obj['surname'];
    this.email = obj['email'];
    this.password = obj['password'];
    this.image = obj['image'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'image':image
    };
    return map;
  }
}
