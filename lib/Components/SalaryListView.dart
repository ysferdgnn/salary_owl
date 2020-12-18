
import 'package:flutter/material.dart';
import 'package:salary_owl/Models/Period.dart';


import 'package:salary_owl/Services/PeriodService.dart';

import 'SalaryExpansionTile.dart';

class SalaryListView extends StatefulWidget {
  @override
  _SalaryListViewState createState() => _SalaryListViewState();
}

class _SalaryListViewState extends State<SalaryListView> {

  List<Period> periodList;

  @override
  Widget build(BuildContext context) {


    PeriodService ps = PeriodService();
    ps.selectPeriods().then((value) {
      setState(() {
        periodList=value.toList();
      });
    });
    return ListView.builder(
        itemCount:  periodList==null ? 0 :periodList.length,
        itemBuilder: (context, index) =>
            SalaryExpansionTile(periodList==null ? Period("") :periodList[index])

      );
  }

}
