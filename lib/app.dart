import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_list/pages/grocery_list.dart';

import 'theme/theme.dart';
import 'pages/home_page.dart';
import 'pages/landing.dart';
import 'pages/login.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: AppTheme.theme,
      initialRoute: 'landing',
      onGenerateRoute: (RouteSettings routeSettings) {
        // Map<String, dynamic> args = routeSettings.arguments;
        switch (routeSettings.name) {
          case AppRoutes.LOGIN_PAGE:
            return MaterialPageRoute(builder: (context) => LoginPage());
          case AppRoutes.HOME_PAGE:
            return MaterialPageRoute(builder: (context) => HomePage());
          case AppRoutes.LANDING_PAGE:
          default:
            return MaterialPageRoute(builder: (context) => LandingPage());
        }
      },
    );
  }
}

class AppRoutes {
  static const LANDING_PAGE = 'landing_page';
  static const LOGIN_PAGE = 'login_page';
  static const HOME_PAGE = 'home_page';
}
