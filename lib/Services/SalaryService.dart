import 'package:salary_owl/Helpers/dbHelper.dart';
import 'package:salary_owl/Models/Salary.dart';
import 'package:sqflite/sqflite.dart';

class SalaryService{
  DbHelper dbHelper=DbHelper();
  Database db;


  Future<int>  insertSalary(Salary salary) async{
    db=await dbHelper.getDatabase();
    return db.insert("Salary", salary.toMap());
  }
  Future<List<Salary>> selectSalary() async{
    db=await dbHelper.getDatabase();
    final maps = await db.query("Salary");
    return List.generate(maps.length, (index) {
      return Salary.fromMap(maps[index]);
    });
  }

 Future<List<Salary>> selectSalaryWithPeriodId(int periodId) async{
    db=await dbHelper.getDatabase();
    final maps =await db.query("Salary",where: "PeriodId=?", whereArgs: [periodId]);
    if(maps==null){
      return null;
    }
    return List.generate(maps.length, (index) {
      return Salary.fromMap(maps[index]);
    });
  }
  Future<int> deleteSalaryWithId(int id) async{
    db=await dbHelper.getDatabase();
    int result = await db.delete("Salary",where: "SalaryId=?",whereArgs: [id]);
    return result;
  }
  Future<int>deleteSalary (Salary salary) async{
    db=await dbHelper.getDatabase();
    int result =await db.delete("Salary",where: "SalaryId=?",whereArgs: [salary.salaryId]);
    return result;
  }
  Future<int> deleteSalaryWithPeriodId(int periodId) async{
    db=await dbHelper.getDatabase();
      int result=await db.delete("Salary",where: "PeriodId=?",whereArgs: [periodId]);
      return result;
   }




}