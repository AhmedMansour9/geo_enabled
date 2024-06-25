import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geo_enabled/data/datasource/remote/dio/dio_client.dart';
import 'package:geo_enabled/data/datasource/remote/exception/api_error_handler.dart';
import 'package:geo_enabled/data/model/response/base/api_response.dart';
import 'package:geo_enabled/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences, required this.dioClient});

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(AppConstants.THEME)) {
      return sharedPreferences.setBool(AppConstants.THEME, false);
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}