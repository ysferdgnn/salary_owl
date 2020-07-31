import 'package:flutter/material.dart';
import 'package:salary_owl/Period.dart';
import 'package:salary_owl/Salary.dart';


class SalaryExpansionTile extends StatefulWidget {
 final Period period;

 SalaryExpansionTile(this.period);
  @override
  _SalaryExpansionTileState createState() => _SalaryExpansionTileState();


}

class _SalaryExpansionTileState extends State<SalaryExpansionTile> {


  @override
  Widget build(BuildContext context) {

    List<Salary> salaryList = widget.period.salaryChild;
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
