import 'package:flutter/foundation.dart';


class CheckedListModel {
  late String? _checkIn;
  late String? _checkOut;

  CheckedListModel({
    String? checkIn,
    String? checkOut,}) {
    this._checkIn = checkIn;
    this._checkOut = checkOut;
  }


  String? get checkIn => _checkIn;

  String? get checkOut => _checkOut;


  CheckedListModel.fromJson(Map<String, dynamic> json) {
    _checkIn = json['check_in'];
    _checkOut = json['check_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['check_in'] = _checkIn;
    data['check_out'] = _checkOut;
    return data;
  }
}