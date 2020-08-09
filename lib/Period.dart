
class Period{
  int _periodId;
  String _title;


  Period(this._title);
  Period.withId(this._periodId,this._title);

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = Map();
    map['periodId']=this._periodId;
    map['title']=this._title;
    return map;
  }
  Period.fromMap(Map<String,dynamic> map){
    if(map['periodId']!=null){
      this.periodId=map['periodId'];
    }
    this.title=map['title'];

  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
  int get periodId => _periodId;

  set periodId(int value) {
    _periodId = value;
  }
}