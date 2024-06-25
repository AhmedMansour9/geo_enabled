import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:geo_enabled/utill/routes.dart';
import 'package:geo_enabled/view/base/not_found.dart';
import 'package:geo_enabled/view/screens/request_leave/LeaveRequestScreen.dart';

import '../view/screens/dashboard/dashboard_screen.dart';
import '../view/screens/auth/login.dart';
import '../view/screens/splash/splash_screen.dart';
import '../view/screens/welcome/welcome_screen.dart';



class RouterHelper {
  static final FluroRouter router = FluroRouter();

//*******Handlers*********
  static final Handler _splashHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => SplashScreen());
  static final Handler _welcomeHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => WelcomeScreen());

  static final Handler _loginHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static final Handler _dashboardHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => DashboardScreen());
  static final Handler _leaveRequestdHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => LeaveRequestScreen());




  // static Handler _dashScreenBoardHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) {
  //   return DashboardScreen(pageIndex: params['page'][0] == 'home' ? 0 : params['page'][0] == 'cart' ? 1 : params['page'][0] == 'order' ? 2
  //       : params['page'][0] == 'favourite' ? 3 : params['page'][0] == 'menu' ? 4 : 0);
  // });

  // static Handler _deshboardHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => DashboardScreen(pageIndex: 0));


  static Handler _notFoundHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => NotFound());



//*******Route Define*********
  static void setupRouter() {
    router.notFoundHandler = _notFoundHandler;
    router.define(Routes.SPLASH_SCREEN, handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.WELCOME_SCREEN, handler: _welcomeHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LOGIN_SCREEN, handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DASHBOARD, handler: _dashboardHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LEAVEREQUEST, handler: _leaveRequestdHandler, transitionType: TransitionType.fadeIn);
  }
}