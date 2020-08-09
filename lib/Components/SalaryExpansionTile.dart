import 'package:flutter/material.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/models/Period.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/models/Salary.dart';
import 'package:salary_owl/Helpers/dbHelper.dart';


class SalaryExpansionTile extends StatefulWidget {
 final Period period;

 SalaryExpansionTile(this.period);
  @override
  _SalaryExpansionTileState createState() => _SalaryExpansionTileState();


}

class _SalaryExpansionTileState extends State<SalaryExpansionTile> {


  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.getDatabase();
  List<Salary> salaryList2=[
    Salary("Haziran banka","2020/07/07",1016.71,1),Salary("İşkur Banka","2020/07/09",623.07,1),Salary("Nakit","2020/07/06",1000,1),
    Salary("Nakit","2020/07/30",1500,2),Salary("Temmuz Banka","2020/07/30",561.06,2)
  ];

    List<Salary> salaryList = salaryList2.where((element) => element.periodId==widget.period.periodId).toList();
    double total= salaryList.map((e) => e.salary).reduce((value, element) => value+element);
    return ExpansionTile(
      title: ListTile(
        leading: Text(widget.period.title),
        title: Padding(
          child: IconButton(icon: Icon(Icons.add),
          onPressed: (){
            debugPrint("eklendi");
          },),
          padding: EdgeInsets.only(left: 150),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: (){
            debugPrint("silindi");
          },
        ),
      ),
      children: <Widget>[
       ListView.builder(
         shrinkWrap: true, // 1st add
         physics: ClampingScrollPhysics(), // 2nd add
         itemCount: salaryList.length,
         itemBuilder: (context, index) =>
         ListTile(
           leading: Text(salaryList[index].source),
           title: Text(salaryList[index].date),
           trailing: Text(salaryList[index].salary.toString()),
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


}
