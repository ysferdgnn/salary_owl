import 'package:salary_owl/Helpers/dbHelper.dart';
import 'package:salary_owl/Models/Period.dart';
import 'package:sqflite/sqflite.dart';

class PeriodService{

  DbHelper dbHelper=DbHelper();
  Database db;

  Future<int> insertPeriod(Period period) async{
    db= await dbHelper.getDatabase();
  return db.insert("Period", period.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Period>> selectPeriods()async{
    db=await dbHelper.getDatabase();
   final maps= await db.query("Period");
    return List.generate(maps.length, (i) {
      return Period.fromMap(maps[i]);
    });
  }
  Future<int>deletePeriod(Period period) async{
    db=await dbHelper.getDatabase();
    int result = await db.delete("Period",where: "PeriodId=?",whereArgs: [period.periodId]);
    return result;
  }
  Future<int> deletePeriodWithId(int periodId ) async{
    db=await dbHelper.getDatabase();
    int result = await db.delete("Period",where: "PeriodId=?",whereArgs: [periodId]);
    return result;
  }


}