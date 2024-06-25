import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geo_enabled/data/datasource/remote/dio/dio_client.dart';
import 'package:geo_enabled/data/datasource/remote/exception/api_error_handler.dart';
import 'package:geo_enabled/data/model/response/base/api_response.dart';
import 'package:geo_enabled/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  HomeRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> checkIn(
      {String? userName,
      String? checkIn,
      String? locationLat,
      String? locationLong}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.USER_CHECKIN,
        data: {
          "username": userName,
          "check_in": checkIn,
          "location_lat": locationLat,
          "location_long": locationLong,
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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
  Future<ApiResponse> requestLeave(
      {String? userName,
      String? startDate,
      String? endDate,
      String? reason,
      int? leaveTypeId}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.USER_LEAVEREQUEST,
        data: {
          "username": userName,
          "start_date": startDate,
          "end_date": endDate,
          "reason": reason,
          "leaveTypeId": leaveTypeId
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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

  Future<ApiResponse> userAllChecks({String? userName}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.USER_ALLCHECKS,
        data: {"username": userName},
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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
  Future<ApiResponse> userAllLeaves({String? userName}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.USER_ALLLEAVES,
        data: {"username": userName},
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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

  Future<ApiResponse> userAllEvents({String? userName, String? date}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.USER_ALLEVENTS,
        data: {
          "username": userName,
          "date": date,
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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

  Future<ApiResponse> checkOut(
      {String? userName,
      String? checkOut,
      String? locationLat,
      String? locationLong}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.USER_CHECKOUT,
        data: {
          "username": userName,
          "check_out": checkOut,
          "location_lat": locationLat,
          "location_long": locationLong,
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
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

  Future<void> saveChecked(bool checked) async {
    try {
      await sharedPreferences.setBool(AppConstants.CHECKED, checked);
    } catch (e) {
      throw e;
    }
  }

  bool isCheckedIn() {
    return sharedPreferences.getBool(AppConstants.CHECKED) ?? false;
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.USERNAME) ?? "";
  }
}
