import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geo_enabled/data/datasource/remote/dio/dio_client.dart';
import 'package:geo_enabled/data/datasource/remote/exception/api_error_handler.dart';
import 'package:geo_enabled/data/model/response/base/api_response.dart';
import 'package:geo_enabled/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});


  Future<ApiResponse> login({String? username, String? password}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: {
          "params": {
            "username": username,
            "password": password
          }
        },
      );
      return ApiResponse.withSuccess(response);
    }  on DioException catch (e) {
      // Handle the DioError here by creating an ApiResponse with the error
      var errorMessage = "An error occurred";
      if (e.response != null) {
        // If the error is due to an HTTP response, use the response's data
        errorMessage = e.response?.data["result"]["message"] ?? "Unknown error";
        return ApiResponse.withError(errorMessage);
      }
      print(errorMessage.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<void> saveUserName(String username) async {
    try {
      await sharedPreferences.setString(AppConstants.USERNAME, username);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserLocation(String latitude,String longitude) async {
    try {
      await sharedPreferences.setString(AppConstants.LOCATION_LATITUDE, latitude);
      await sharedPreferences.setString(AppConstants.LOCATION_LONGTUDE, longitude);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserData(String name,String position,String birthdate,String email,String start_date) async {
    try {
      await sharedPreferences.setString(AppConstants.NAME, name);
      await sharedPreferences.setString(AppConstants.EMPLOYEEPOSITION, position);
      await sharedPreferences.setString(AppConstants.EMPLOYEEBIRTHDATE, birthdate);
      await sharedPreferences.setString(AppConstants.EMPLOYEEEMAIL, email);
      await sharedPreferences.setString(AppConstants.EMPLOYEESTARTDATE, start_date);
    } catch (e) {
      throw e;
    }
  }


  Future<void> saveIsRegistered(String token) async {

    try {
      await sharedPreferences.setString("registered", token);
    } catch (e) {
      throw e;
    }
  }
  Future<void> clearShared() async {

    try {
      await sharedPreferences.clear();
    } catch (e) {
      throw e;
    }
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.USERNAME) ?? "";
  }
  String getUserStartDate() {
    return sharedPreferences.getString(AppConstants.EMPLOYEESTARTDATE) ?? "";
  }
  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.EMPLOYEEEMAIL) ?? "";
  }
  String getUserPosition() {
    return sharedPreferences.getString(AppConstants.EMPLOYEEPOSITION) ?? "";
  }
  String getUserFillName() {
    return sharedPreferences.getString(AppConstants.NAME) ?? "";
  }
  String getUserBirthDate() {
    return sharedPreferences.getString(AppConstants.EMPLOYEEBIRTHDATE) ?? "";
  }
  String getUserLocationLatitude() {
    return sharedPreferences.getString(AppConstants.LOCATION_LATITUDE) ?? "";
  }
  String getUserLocationLongetude() {
    return sharedPreferences.getString(AppConstants.LOCATION_LONGTUDE) ?? "";
  }

  bool isLoggedIn() {
    return (sharedPreferences.containsKey(AppConstants.USERNAME));
  }

  Future<void> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.USERNAME);
    await sharedPreferences.remove("registered");
    await sharedPreferences.clear();
  }


}
