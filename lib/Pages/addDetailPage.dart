import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:salary_owl/Models/Period.dart';
import 'package:salary_owl/Models/Salary.dart';
import 'package:salary_owl/Services/PeriodService.dart';
import 'package:salary_owl/Services/SalaryService.dart';

class AddDetailPage extends StatefulWidget {
  @override
  _AddDetailPageState createState() => _AddDetailPageState();
}

class _AddDetailPageState extends State<AddDetailPage> {
  Period selectedPeriod = new Period("");
  List<Period> periodList;
  DateTime selectedDate;
  String selectedDateText = "";

  var txtKaynakController = TextEditingController();
  var txtTarihController = TextEditingController();
  var txtTutarController = TextEditingController();

  SalaryService salaryService = SalaryService();

  @override
  void initState() {
    PeriodService ps = PeriodService();
    ps.selectPeriods().then((value) {
      setState(() {
        periodList = value.toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedPeriod.periodId == null) {
      return PeriodList();
    } else {
      return addSalaryWidget();
    }
  }

  Widget PeriodList() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary Owl"),
      ),
      body: ListView.builder(
          itemCount: periodList == null ? 0 : periodList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: periodList == null
                    ? Text('')
                    : Text(periodList[index].title),
                onTap: () {
                  setState(() {
                    selectedPeriod = periodList[index];
                  });
                },
              ),
            );
          }),
    );
  }

  Widget addSalaryWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary Owl"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "kaynak"),
                controller: txtKaynakController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(labelText: "tarih"),
                controller: txtTarihController,
                onTap: () {
                  pickDate();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(labelText: "tutar"),
                controller: txtTutarController,
                 keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  child: Text("Kaydet"),
                  onPressed: () {
                    Salary salary = Salary(
                        txtKaynakController.text,
                        selectedDateText,
                        double.parse(txtTutarController.text),
                        selectedPeriod.periodId);
                    salaryService.insertSalary(salary);
                    setState(() {
                      selectedPeriod=Period("");
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }

  void pickDate() {
    DatePicker.showDatePicker(context,
        currentTime: DateTime.now(),
        locale: LocaleType.tr,
        minTime: DateTime(2010, 01, 01),
        maxTime: DateTime(2200, 01, 01), onConfirm: (date) {
      setState(() {
        selectedDate = date;
        selectedDateText = selectedDate.year.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.day.toString();
        txtTarihController.text = selectedDateText;
      });
    });
  }
}
