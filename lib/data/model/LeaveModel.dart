
class LeaveModel {
  late String? _startDate;
  late String? _endDate;
  late String? _reason;
  late String? _status;
  late String? _type;

  LeaveModel({
    String? startDate,
    String? endDate,
    String? reason,
    String? status,
    String? type,
  }) {
    this._startDate = startDate;
    this._endDate = endDate;
    this._reason = reason;
    this._status = status;
    this._type = type;
  }

  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get reason => _reason;
  String? get status => _status;
  String? get type => _type;

  LeaveModel.fromJson(Map<String, dynamic> json) {
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _reason = json['reason'];
    _status = json['status'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = _startDate;
    data['end_date'] = _endDate;
    data['reason'] = _reason;
    data['status'] = _status;
    data['type'] = _type;
    return data;
  }
}
