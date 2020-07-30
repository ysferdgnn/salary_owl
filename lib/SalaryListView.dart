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
    List<Salary> salaryList=[Salary("test1",10,"2020/07/31"),Salary("test2",20,"2020/07/11"),Salary("test3",15,"2020/07/01")];
    List<Period> periodList =[Period("202003",salaryList),Period("202004",salaryList)];





    return ListView.builder(
        itemCount: periodList.length,
        itemBuilder: (context, index) =>
            SalaryExpansionTile(periodList[index])

      );
  }
}
