import 'dart:io';

import 'package:flutter/material.dart';
import 'package:session/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObj();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObj();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'flutter.db';
    var todoDB = await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDB;
  }

  _createDb(Database database, int version) async {
    database.execute('''CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    password TEXT,
    bio TEXT,
    token TEXT NULLABLE
    )''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<int> insertUser(User user) async {
    Database db = await this.database;
    int result = await db.insert('users', user.toMap());
    return result;
  }

  Future<int> deleteUser(User user) async {
    Database db = await this.database;
    int result = await db.delete('users', where: 'id=?', whereArgs: [user.id]);
    return result;
  }

  Future<List<User>> getUserList() async {
    var userMapList = await select();
    int result = userMapList.length;
    List<User> userList = List<User>();
    for (int i = 0; i < result; i++) {
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('users', orderBy: 'name');
    return mapList;
  }

  Future<User> getUser(String name, String email, String password) async {
    Database db = await this.database;
    var mUser = await db.query('users',
        where: 'name=? AND email=? AND password=?',
        whereArgs: [name, email, password]);
    try {
      if (mUser.length == 0) {
        name.toString();
        email.toString();
        password.toString();
        return User.fromMap(mUser.first);
      } else {
        return null;
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
