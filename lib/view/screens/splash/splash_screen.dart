import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geo_enabled/provider/auth_provider.dart';
import 'package:geo_enabled/utill/color_resources.dart';
import 'package:geo_enabled/utill/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/custom_snackbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    _route();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _route() {
    Timer(const Duration(seconds: 3), () async {
      if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.getMainRoute(), (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.getWelcomeRoute(), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: _globalKey,
        child: Scaffold(
            //key: _globalKey,
            backgroundColor: ColorResources.COLOR_SPLASH,
            body: Center(
              child: Container(
                child: Image.asset(
                  'assets/image/logo-splash.png',
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            )));
  }
}
