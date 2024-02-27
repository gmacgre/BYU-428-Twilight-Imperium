class Objective {
  final int _id;
  final Set<int> _completed;
  Objective(this._id, this._completed, this._pointValue);
  final int _pointValue;
  bool hasCompleted(int id) {
    return _completed.contains(id);
  }
  void complete(int id) {
    _completed.add(id);
  }
  int getValue() {
    return _pointValue;
  }
  int getId() {
    return _id;
  }

}