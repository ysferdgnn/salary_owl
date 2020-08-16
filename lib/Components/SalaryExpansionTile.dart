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

  String salarySource,salaryDate;
  double salaryMoney;

  List<Salary> salaryList=null ;
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.getDatabase();

    SalaryService salaryService=SalaryService();
    salaryService.selectSalaryWithPeriodId(widget.period.periodId).then((value) {
      setState(() {
        salaryList=value.toList();
      });
    });
  //List<Salary> salaryList2=[
   // Salary("Haziran banka","2020/07/07",1016.71,1),Salary("İşkur Banka","2020/07/09",623.07,1),Salary("Nakit","2020/07/06",1000,1),
   // Salary("Nakit","2020/07/30",1500,2),Salary("Temmuz Banka","2020/07/30",561.06,2)
 // ];
  //salaryList2=null;

  //  List<Salary> salaryList =salaryList2==null ? null : salaryList2.where((element) => element.periodId==widget.period.periodId).toList();

    MediaQueryData mqd=MediaQuery.of(context);
    double width = mqd.size.width;



    double total= 0;//salaryList==null? 0: salaryList.map((e) => e.salary).reduce((value, element) => value+element);
    return ExpansionTile(
      title: ListTile(
        leading: Text(widget.period.title),
        title:  Padding(
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.add),
                onPressed: (){
                  _showAddSalaryAlert(context,widget.period.periodId);
                  debugPrint("eklendi");
                },),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  _showDeletePeriodAlert(context,widget.period.periodId);
                },
              ),

            ],
          ),
          padding: EdgeInsets.only(left: width/2.9),
        ), 
          



      ),
      children: <Widget>[
       ListView.builder(
         shrinkWrap: true, // 1st add
         physics: ClampingScrollPhysics(), // 2nd add
         itemCount: salaryList==null ? 0 : salaryList.length,
         itemBuilder: (context, index) =>
         ListTile(
           leading: Text(salaryList==null? "" :salaryList[index].source),
           title: Text(salaryList==null? "" :salaryList[index].date),
           trailing: Text(salaryList==null? "" :salaryList[index].salary.toString()),
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

  _showAddSalaryAlert(BuildContext context,int periodId){
    Alert(
      context: context,
      title: "Add Salary",
      content: Column(
        children: <Widget>[
          TextField( decoration: InputDecoration(hintText: "source"),onChanged: (value){
            setState(() {
              salarySource=value;
            });
          }),
          IconButton(icon: Icon(Icons.date_range),
          onPressed: (){
            showDatePicker(context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2001),
                lastDate: DateTime(2300)
            ).then((value) {
              salaryDate=value.toString();
            });

          },

          ),
         TextField(keyboardType: TextInputType.number, decoration: InputDecoration(hintText: "salary"),
         inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
         onChanged: (value){
           setState(() {
             salaryMoney=double.parse(value);
           });
         },)
        ],
      ),
      buttons: [
        DialogButton(
          child: Text("Add"),
          onPressed: (){
            SalaryService salaryService=SalaryService();
            Salary s= Salary(salarySource,salaryDate,salaryMoney,periodId);
            salaryService.insertSalary(s);
          }

        ),
        DialogButton(
          child: Text("Close"),
          onPressed: (){
            Navigator.pop(context);
        },
        )
      ]
    )
        .show();

  }


  _showDeletePeriodAlert(context,int periodId){
    Alert(
        context: context,
        title: "Are You Sure ?",
        buttons: [
          DialogButton(
            child: Text("Delete"),
            onPressed: (){
              _deletePeriod(periodId);
              Navigator.pop(context);
            },
          ),
          DialogButton(
            child: Text("Close"),
            onPressed:(){
              Navigator.pop(context);
            },
          )
        ]

    ).show();
  }

  _deletePeriod(int periodId){
    PeriodService ps =new PeriodService();
    SalaryService ss = SalaryService();
    ss.selectSalaryWithPeriodId(periodId);
    ps.deletePeriodWithId(periodId);
  }
}
