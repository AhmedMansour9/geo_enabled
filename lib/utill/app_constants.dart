
import '../data/model/response/language_model.dart';
import 'images.dart';

class AppConstants {

  static const String APP_NAME = 'Geo Enabled';

  // static const String BASE_URL = 'http://45.94.209.181:8045/';
  static const String BASE_URL = 'https://geohr.strategizeit.us/';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String USERNAME = 'username';
  static const String NAME = 'name';
  static const String EMPLOYEEPOSITION = 'employee_position';
  static const String EMPLOYEEBIRTHDATE = 'employee_birthdate';
  static const String EMPLOYEEEMAIL = 'employee_email';
  static const String EMPLOYEESTARTDATE = 'start_date';
  static const String CHECKED = 'checked';
  static const String LOCATION_LATITUDE = 'latitude';
  static const String LOCATION_LONGTUDE = 'longtude';

  static const String LOGIN_URI = "user_login";
  static const String USER_CHECKIN = "user_attendence_in";
  static const String USER_LEAVEREQUEST = "user_holiday_request";
  static const String USER_ALLCHECKS = "user_all_checks";
  static const String USER_ALLLEAVES = "user_all_hreq";
  static const String USER_ALLEVENTS = "user_all_event";
  static const String USER_CHECKOUT = "user_attendence_out";

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.united_kindom, languageName: 'English', countryCode: 'US', languageCode: 'en'),

    LanguageModel(imageUrl: Images.arabic, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),

  ];

}
