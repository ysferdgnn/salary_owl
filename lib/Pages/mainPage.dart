


import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salary_owl/Components/SalaryListView.dart';
import 'package:salary_owl/Models/Period.dart';
import 'package:salary_owl/Services/PeriodService.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        title: "Dönem",
        desc: "Yeni Dönem Ekle",
        buttons: [
          DialogButton(
            child: Text("ekle"),
            onPressed: (){

              _addPeriod(periodTitle);
              Navigator.pop(context);
            },
          ),
          DialogButton(
            child: Text("Kapat"),
            onPressed:()=> Navigator.pop(context),
          )
        ],
        content: Container(
          child: Column(
            children: <Widget>[
              TextField(decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Dönem",
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
    setState(() {
      periodTitle="";
    });
  }
}
