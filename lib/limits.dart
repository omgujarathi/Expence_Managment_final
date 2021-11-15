class limit {


  late String _category;
  late String _description;
  late int _limits_amount;
  limit(this._category,this._limits_amount,this._description);
  int? _id;
  limit.withId(this._id, this._category, this._limits_amount,this._description);

  int? get id => _id;

  String get category => _category;

  String get description => _description;
  int get limits_amount => _limits_amount;


  set category(String newcategory) {
    if (newcategory.length <= 255) {
      this._category = newcategory;
    }
  }

  set description(String newdescription) {
    this._description = newdescription;
  }
  set limits_amount(int newlimits_amount) {
    this._limits_amount = newlimits_amount;
  }

  // Convert a limit object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['category'] = _category;
    map['limits_amount']=_limits_amount;
    map['description']=_description;
    return map;
  }

  // Extract a limit object from a Map object
  limit.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._category = map['category'];
    this._limits_amount=map['limits_amount'];
    this._description=map['description'];

  }
}
