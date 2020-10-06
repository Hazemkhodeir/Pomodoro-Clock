import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timer_clock/models/task.dart';

class DatabaseHelper extends ChangeNotifier {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String tableName = 'task_table';
  String colId = 'id';
  String colName = 'name';
  String colDuration = 'duration';
  String colTimePassed = 'timePassed';
  String colPercent = 'percent';

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }
  Future<Database> get databse async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'note.db';
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    notifyListeners();
    return notesDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colDuration TEXT, $colPercent TEXT, $colTimePassed TEXT)');
    notifyListeners();
  }

  //Insert to Databse
  Future<int> insertTask(Task task) async {
    Database db = await this.databse;
    var result = await db.insert(tableName, task.toMap());
    notifyListeners();
    return result;
  }

  //Update in Database
  Future<int> updateTask(Task task) async {
    Database db = await this.databse;
    var result = await db.update(tableName, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  //Delete from Databse
  Future<int> deleteTask(int id) async {
    Database db = await this.databse;
    int result =
        await db.rawDelete('DELETE FROM $tableName WHERE $colId = $id');
    notifyListeners();
    return result;
  }

  //Get number of Notes in Databse
  Future<int> getCount() async {
    Database db = await this.databse;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //List All Tasks from DataBase
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.databse;
    var result = await db.query(tableName);
    return result;
  }

  // get the map list and convert it to notelist
  Future<List<Task>> getTaskList() async {
    var noteMapList = await getTaskMapList();
    int count = noteMapList.length;
    List<Task> taskList = List<Task>();
    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMapObject(noteMapList[i]));
    }
    return taskList;
  }
}
