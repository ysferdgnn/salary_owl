import 'package:flutter/material.dart';
import 'package:salary_owl/SalaryExpansionTile.dart';
import 'package:salary_owl/SalaryListView.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Salary Owl"),
        ),
      body: SalaryListView()
    );
  }
}
