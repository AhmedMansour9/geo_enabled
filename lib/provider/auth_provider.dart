import 'package:flutter/foundation.dart';
import 'package:geo_enabled/data/model/response/base/api_response.dart';
import 'package:geo_enabled/data/model/response/base/error_response.dart';
import 'package:geo_enabled/data/model/response/response_model.dart';
import 'package:geo_enabled/data/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  // for registration section
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // for login section
  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo.login(username: email, password: password);
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String username = map["result"]["username"];
      String locationLat = map["result"]["location_lat"];
      String locationLong = map["result"]["location_long"];
      authRepo.saveUserName(username);
      authRepo.saveUserLocation(locationLat, locationLong);
      authRepo.saveUserData(
          map["result"]["name"],
          map["result"]["Employee_postition"],
          map["result"]["employee_birthdate"],
          map["result"]["employee_email"],
          map["result"]["start_date"]);
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage = apiResponse.error.toString();
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<void> clearSharedData() async {
    _isLoading = true;
    notifyListeners();
     await authRepo.clearSharedData();
    _isLoading = false;
    notifyListeners();

  }

  String getUserName() {
    return authRepo.getUserName();
  }
  String getUserFullName() {
    return authRepo.getUserFillName();
  }
  String getUserPosition() {
    return authRepo.getUserPosition();
  }
  String getUserEmail() {
    return authRepo.getUserEmail();
  }
  String getUserBirthDate() {
    return authRepo.getUserBirthDate();
  }
  String getUserStartDate() {
    return authRepo.getUserStartDate();
  }

  String getUserLocationLatitude() {
    return authRepo.getUserLocationLatitude();
  }

  String getUserLocationLongetude() {
    return authRepo.getUserLocationLongetude();
  }
}
