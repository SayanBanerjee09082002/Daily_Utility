class Note {

  int? _id;
  String? _title;
  String? _description;
  DateTime? _date;

  Note (this._id, this._title, this._description, this._date);

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  DateTime? get date => _date;

  set title(String? newTitle) => this._title = newTitle;
  set description(String? newDescription) => this._description = newDescription;
  set date(DateTime? newDate) => this._date = newDate;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
  }
}