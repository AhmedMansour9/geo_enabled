import 'dart:convert';

class Routes {

  static const String SPLASH_SCREEN = '/';
  static const String LANGUAGE_SCREEN = '/select-language';
  static const String ONBOARDING_SCREEN = '/onboarding';
  static const String WELCOME_SCREEN = '/welcome';
  static const String LOGIN_SCREEN = '/login';
  static const String DASHBOARD = '/home';
  static const String LEAVEREQUEST = '/leave_request';


  static String getSplashRoute() => SPLASH_SCREEN;
  static String getLanguageRoute(String page) => '$LANGUAGE_SCREEN?page=$page';
  static String getOnBoardingRoute() => ONBOARDING_SCREEN;
  static String getWelcomeRoute() => WELCOME_SCREEN;
  static String getLoginRoute() => LOGIN_SCREEN;
  static String getMainRoute() => DASHBOARD;
  static String getLeaveRequestRoute() => LEAVEREQUEST;

}