import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:salary_owl/Period.dart';
import 'package:salary_owl/Salary.dart';
import 'package:salary_owl/SalaryExpansionTile.dart';

class SalaryListView extends StatefulWidget {
  @override
  _SalaryListViewState createState() => _SalaryListViewState();
}

class _SalaryListViewState extends State<SalaryListView> {
  @override
  Widget build(BuildContext context) {
    List<Salary> salaryList=[Salary("Haziran banka",1016.71,"2020/07/07"),Salary("İşkur Banka",623.07,"2020/07/09"),Salary("Nakit",1000,"2020/07/06")];
    List<Salary> salaryList2=[Salary("Nakit",1500,"2020/07/30"),Salary("Temmuz Banka",561.06,"2020/07/30")];
    List<Period> periodList =[Period("202006",salaryList),Period("202007",salaryList2)];





    return ListView.builder(
        itemCount: periodList.length,
        itemBuilder: (context, index) =>
            SalaryExpansionTile(periodList[index])

      );
  }
}
