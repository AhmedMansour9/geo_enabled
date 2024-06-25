import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_enabled/helper/router_helper.dart';
import 'package:geo_enabled/localization/app_localization.dart';
import 'package:geo_enabled/provider/auth_provider.dart';
import 'package:geo_enabled/provider/home_provider.dart';
import 'package:geo_enabled/provider/localization_provider.dart';
import 'package:geo_enabled/provider/language_provider.dart';
import 'package:geo_enabled/provider/theme_provider.dart';
import 'package:geo_enabled/theme/dark_theme.dart';
import 'package:geo_enabled/theme/light_theme.dart';
import 'package:geo_enabled/utill/app_constants.dart';
import 'package:geo_enabled/utill/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'di_container.dart' as di;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>())
    ],
    child: MyApp(isWeb: !kIsWeb),
  ));
}

class MyApp extends StatefulWidget {
  final bool isWeb;

  MyApp({required this.isWeb});

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    RouterHelper.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode!, language.countryCode));
    });

    return MaterialApp(
      // initialRoute: ResponsiveHelper.isMobilePhone() ? widget.orderId == null ? Routes.getSplashRoute()
      //     : Routes.getOrderDetailsRoute(widget.orderId) : Routes.getMainRoute(),
      // initialRoute: Routes.getMainRoute(),
      onGenerateRoute: RouterHelper.router.generator,
      title: "",
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      // locale: Provider.of<LocalizationProvider>(context).locale,
      // localizationsDelegates: const [
      //   AppLocalization.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      supportedLocales: _locals,
    );
  }
}
