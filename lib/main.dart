import 'package:flutter/material.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/Components/SalaryExpansionTile.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/Components/SalaryListView.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salary_owl/Models/Period.dart';
import 'package:salary_owl/Services/PeriodService.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String periodTitle="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Salary Owl"),
        ),
      body: SalaryListView(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        onPressed: ()=>_showAddAlert(context),
    ),
    );
  }

  _showAddAlert(context){
    Alert(
        context: context,
        title: "Add Period",
        desc: "add a new period for your salary",
        buttons: [
          DialogButton(
            child: Text("Add"),
            onPressed: (){

              _addPeriod(periodTitle);
              Navigator.pop(context);
            },
          ),
          DialogButton(
            child: Text("Close"),
            onPressed:()=> Navigator.pop(context),
          )
        ],
        content: Container(
          child: Column(
            children: <Widget>[
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Period Name",
              ),
                onChanged: (value)  {
                  this.setState(() {
                    periodTitle=value;
                  });
                },

              ),

            ],
          ),
        )
    ).show();
  }

  _addPeriod(String periodTitle) async{
    Period p = Period(periodTitle);
    PeriodService ps = PeriodService();
    int sonuc= await ps.insertPeriod(p);
    debugPrint(sonuc.toString());
    setState(() {
      periodTitle="";
    });
  }



}


