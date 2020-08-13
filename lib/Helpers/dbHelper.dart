import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  static DbHelper _dbHelper;
  static Database _database;

  //table period
  String _tablePeriod="Period";
  String _periodId="periodId";
  String _periodTitle="title";

  //table Salary
  String _tableSalary="Salary";
  String _salaryId="salaryId";
  String _source="source";
  String _date="date";
  String _salary="salary";
  String _periodIdSalary="periodId";

  factory DbHelper(){
    if(_dbHelper==null){
      _dbHelper=DbHelper._internal();
    }
    return _dbHelper;
  }
  DbHelper._internal();

  Future<Database> getDatabase() async{
    if(_database==null){
      _database= await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {

    Directory klasor =await getApplicationDocumentsDirectory();
    String dbPath = klasor.path+"/salaryData.db";
    debugPrint(dbPath);
    var ogrencidb=openDatabase(dbPath,version: 1,onCreate: _createDb);
    debugPrint("db açıldı");

    return ogrencidb;
  }
  Future<void> _createDb(Database db,int version) async{
    await db.execute("CREATE TABLE $_tablePeriod ($_periodId INTEGER  PRIMARY KEY AUTOINCREMENT,$_periodTitle TEXT)");
    await db.execute("CREATE TABLE $_tableSalary ($_salaryId INTEGER PRIMARY KEY AUTOINCREMENT,$_source TEXT,$_date TEXT,$_salary NUMERIC,$_periodIdSalary INTEGER)");

    debugPrint("tablolar oluşturuldu");
  }

}