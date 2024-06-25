import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geo_enabled/data/model/response/base/api_response.dart';
import 'package:geo_enabled/data/model/response/base/error_response.dart';
import 'package:geo_enabled/data/model/response/response_model.dart';
import 'package:geo_enabled/data/repository/auth_repo.dart';
import 'package:geo_enabled/data/repository/home_repo.dart';

import '../data/model/CheckedListModel.dart';
import '../data/model/LeaveModel.dart';
import '../data/model/response/EventModel.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepo homeRepo;

  HomeProvider({required this.homeRepo});

  // for registration section
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // for login section
  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  List<CheckedListModel>? get checkedList => _checkedList;
  List<EventModel>? get eventsList => _eventsList;
  List<LeaveModel>? get levelsList => _levelsList;

  List<CheckedListModel>? _checkedList;
  List<EventModel>? _eventsList;

  List<LeaveModel>? _levelsList;



  Future<void> getAllChecks(BuildContext context, bool reload,
      String userName) async {

    if (_checkedList == null || reload) {
      _isLoading = true;
      ApiResponse apiResponse = await homeRepo.userAllChecks(
          userName: userName);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        _checkedList = [];
        Map<String, dynamic> map = apiResponse.response?.data;
        List<dynamic> data = map["result"]["data"];
        _checkedList = data.map((category) => CheckedListModel.fromJson(category)).toList();

      }
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> getAllLeaves(BuildContext context, bool reload,
      String userName) async {

    if (_levelsList == null || reload) {
      _isLoading = true;
      ApiResponse apiResponse = await homeRepo.userAllLeaves(
          userName: userName);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        _levelsList = [];
        Map<String, dynamic> map = apiResponse.response?.data;
        List<dynamic> data = map["result"]["data"];
        _levelsList = data.map((category) => LeaveModel.fromJson(category)).toList();

      }
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> getAllEvents(BuildContext context, bool reload,
      String userName,String date) async {

    if (_eventsList == null || reload) {
      _isLoading = true;
      ApiResponse apiResponse = await homeRepo.userAllEvents(
          userName: userName,date: date);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        _eventsList = [];
        Map<String, dynamic> map = apiResponse.response?.data;
        if ( map["result"]["code"] != 401){
          List<dynamic> data = map["result"]["data"];
          _eventsList = data.map((category) => EventModel.fromJson(category)).toList();

        }

      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ResponseModel> checkIn(String userName, String checkIn,
      String locationLat, String locationLong) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.checkIn(
        userName: userName,
        checkIn: checkIn,
        locationLat: locationLat,
        locationLong: locationLong);
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String message = map["result"]["message"];
      homeRepo.saveChecked(true);
      responseModel = ResponseModel(true, message);
    } else {
      String errorMessage = apiResponse.error.toString();
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> requestLeave(String userName, String startDate,
      String endDate, String reason, int leaveTypeId) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.requestLeave(
        userName: userName,
        startDate: startDate,
        endDate: endDate,
        reason: reason, leaveTypeId: leaveTypeId);
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String message = map["result"]["message"];
      homeRepo.saveChecked(true);
      responseModel = ResponseModel(true, message);
    } else {
      String errorMessage = apiResponse.error.toString();
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> checkOut(String userName, String checkOut,
      String locationLat, String locationLong) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.checkOut(
        userName: userName,
        checkOut: checkOut,
        locationLat: locationLat,
        locationLong: locationLong);
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      homeRepo.saveChecked(false);
      Map map = apiResponse.response?.data;
      String message = map["result"]["message"];
      // homeRepo.saveUserName(username);
      responseModel = ResponseModel(true, message);
    } else {
      String errorMessage = apiResponse.error.toString();
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  bool isCheckedIn() {
    return homeRepo.isCheckedIn();
  }
}

