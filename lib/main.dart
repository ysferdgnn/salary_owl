import 'package:flutter/material.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/Components/SalaryExpansionTile.dart';
import 'file:///C:/Users/ysfer/AndroidStudioProjects/salary_owl/lib/Components/SalaryListView.dart';

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
      body: SalaryListView(),
        floatingActionButton: FloatingActionButton(
        onPressed: null,
    ),
    );
  }
}
