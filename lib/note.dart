class Note {


 late String _category;
  late String _description;
 late String _date;
 late int _amount;
 late String _time;
  Note(this._category, this._date,this._time,this._amount, this._description,);
 int? _id;
  Note.withId(this._id, this._category, this._date,this._time,this._amount, this._description);

  int? get id => _id;

  String get category => _category;

  String get description => _description;

  String get time => _time;
  int get amount => _amount;
  String get date => _date;

  set category(String newcategory) {
    if (newcategory.length <= 255) {
      this._category = newcategory;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }
  set time(String newtime) {
    if (newtime.length <= 255) {
      this._time = newtime;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }
  set amount(int newamount) {
    this._amount = newamount;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['category'] = _category;
    map['description'] = _description;
    map['time'] = _time;
    map['amount']=_amount;
    map['date'] = _date;
    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._category = map['category'];
    this._description = map['description'];
    this._time = map['time'];
    this._amount=map['amount'];
    this._date = map['date'];
  }
}
