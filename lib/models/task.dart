class Task {
  int _id;
  String _name;
  int _duration;
  double _percent;
  int _timePassed;

  int get id => this._id;

  set id(int value) => this._id = value;

  String get name => this._name;

  set name(String value) => this._name = value;

  int get duration => this._duration;

  set duration(int value) => this._duration = value;

  double get percent => this._percent;

  set percent(double value) => this._percent = value;

  int get timePassed => this._timePassed;

  set timePassed(int value) => this._timePassed = value;
  Task(this._name, this._duration, this._percent, this._timePassed);
  Task.withID(
      this._id, this._name, this._duration, this._percent, this._timePassed);

  //Convert To Map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id.toString();
    }
    map['name'] = _name;
    map['duration'] = _duration.toString();
    map['timePassed'] = _timePassed.toString();
    map['percent'] = _percent.toString();
    return map;
  }

  // Convert Map object to Note
  Task.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._duration = int.parse(map['duration']);
    this._timePassed = int.parse(map['timePassed']);
    this._percent = double.parse(map['percent']);
  }
}
