
import 'package:flutter/material.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/models/Period.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/Components/SalaryExpansionTile.dart';

class SalaryListView extends StatefulWidget {
  @override
  _SalaryListViewState createState() => _SalaryListViewState();
}

class _SalaryListViewState extends State<SalaryListView> {
  @override
  Widget build(BuildContext context) {
   // List<Salary> salaryList=[Salary("Haziran banka",1016.71,"2020/07/07"),Salary("İşkur Banka",623.07,"2020/07/09"),Salary("Nakit",1000,"2020/07/06")];
   // List<Salary> salaryList2=[Salary("Nakit",1500,"2020/07/30"),Salary("Temmuz Banka",561.06,"2020/07/30")];
    List<Period> periodList =[Period.withId(1,"202006"),Period.withId(2,"202007")];





    return ListView.builder(
        itemCount: periodList.length,
        itemBuilder: (context, index) =>
            SalaryExpansionTile(periodList[index])

      );
  }
}
