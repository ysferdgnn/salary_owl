import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:salary_owl/Helpers/dbHelper.dart';
import 'package:salary_owl/Models/Period.dart';
import 'package:salary_owl/Models/Salary.dart';
import 'package:salary_owl/Services/PeriodService.dart';
import 'package:salary_owl/Services/SalaryService.dart';

class SalaryExpansionTile extends StatefulWidget {
  final Period period;

  SalaryExpansionTile(this.period);
  @override
  _SalaryExpansionTileState createState() => _SalaryExpansionTileState();
}

class _SalaryExpansionTileState extends State<SalaryExpansionTile> {
  String salarySource, salaryDate;
  double salaryMoney;

  List<Salary> salaryList = null;
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.getDatabase();

    SalaryService salaryService = SalaryService();
    salaryService
        .selectSalaryWithPeriodId(widget.period.periodId)
        .then((value) {
      setState(() {
        salaryList = value.toList();
      });
    });

    MediaQueryData mqd = MediaQuery.of(context);
    double width = mqd.size.width;

    double total=0;
    if(salaryList!=null && salaryList.length>0){
      total =  salaryList
          .map((e) => e.salary)
          .reduce((value, element) => value + element);
    }

    return ExpansionTile(
      title: ListTile(
        leading: Text(widget.period.title),
        onLongPress: () {
          _showDeletePeriodAlert(context, widget.period.periodId);
        },
      ),
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true, // 1st add
          physics: ClampingScrollPhysics(), // 2nd add
          itemCount: salaryList == null ? 0 : salaryList.length,
          itemBuilder: (context, index) => ListTile(
            onLongPress: (){
              _showDeleteSalaryAlert(context,salaryList[index]);
            },
            leading: Text(salaryList == null ? "" : salaryList[index].source),
            title: Text(salaryList == null ? "" : salaryList[index].date),
            trailing: Text(
                salaryList == null ? "" : salaryList[index].salary.toString()),
          ),
        ),
        ListTile(
          leading: Icon(Icons.today),
          title: Text("Total"),
          trailing: Text(total.toString()),
        )
      ],
    );
  }

  _showDeletePeriodAlert(context, int periodId) {
    Alert(
        context: context,
        title: "Kaydı silmek istediğine emin misin?",
        buttons: [
          DialogButton(
            child: Text("Sil"),
            onPressed: () {
              _deletePeriod(periodId);
              Navigator.pop(context);
            },
          ),
          DialogButton(
            child: Text("Kapat"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]).show();
  }

  _showDeleteSalaryAlert(context,Salary salary) {
    Alert(
        context: context,
        title: "Kaydı silmek istediğine emin misin?",
        buttons: [
          DialogButton(
            child: Text("Sil"),
            onPressed: () {
              _deleteSalary(salary);
              Navigator.pop(context);
            },
          ),
          DialogButton(
            child: Text("Kapat"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]).show();
  }

  _deletePeriod(int periodId) {
    PeriodService ps = new PeriodService();
    SalaryService ss = SalaryService();
    ss.selectSalaryWithPeriodId(periodId);
    ps.deletePeriodWithId(periodId);
  }

  _deleteSalary(Salary salary) {
    debugPrint("silindi");
    SalaryService ss = SalaryService();
    ss.deleteSalary(salary);

  }
}
