import 'package:flutter/foundation.dart';

class EventModel {
  late String? _startDate;
  late String? _endDate;
  late String? _subject;
  late String? _desc;
  late String? _location;
  late double? _duration;

  EventModel({
    String? startDate,
    String? endDate,
    String? subject,
    String? desc,
    String? location,
    double? duration,
  }) {
    this._startDate = startDate;
    this._endDate = endDate;
    this._subject = subject;
    this._desc = desc;
    this._location = location;
    this._duration = duration;
  }

  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get subject => _subject;
  String? get desc => _desc;
  String? get location => _location;
  double? get duration => _duration;

  EventModel.fromJson(Map<String, dynamic> json) {
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _subject = json['subject'];
    _desc = json['desc'];
    _location = json['location'];
    _duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = _startDate;
    data['end_date'] = _endDate;
    data['subject'] = _subject;
    data['desc'] = _desc;
    data['location'] = _location;
    data['duration'] = _duration;
    return data;
  }
}
