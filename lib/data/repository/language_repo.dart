import 'package:flutter/material.dart';
import 'package:geo_enabled/data/model/response/language_model.dart';
import 'package:geo_enabled/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
