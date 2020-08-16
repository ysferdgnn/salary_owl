
class Salary {

  int salaryId;
  String _source;
  String _date;
  double _salary;
  int _periodId;


  Salary(this._source, this._date, this._salary, this._periodId);
  Salary.withId(this.salaryId,this._source, this._date, this._salary, this._periodId);

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=Map();
    map['salaryId']=this.salaryId;
    map['source']=this.source;
    map['date']=this.date;
    map['salary']=this.salary;
    map['periodId']=this.periodId;
    return map;
  }
  Salary.fromMap(Map<String,dynamic> map){
    if(map['salaryId']!=null){
      this.salaryId=map['salaryId'];
    }
    String salaryInMap=map['salary']==null ? "0" : map['salary'].toString();
    this.source=map['source'];
    this.date=map['date'];
    this.salary=double.parse(salaryInMap);
    this.periodId=map['periodId'];
  }

  String get source => _source;

  set source(String value) {
    _source = value;
  }

  String get date => _date;

  int get periodId => _periodId;

  set periodId(int value) {
    _periodId = value;
  }

  double get salary => _salary;

  set salary(double value) {
    _salary = value;
  }

  set date(String value) {
    _date = value;
  }
}