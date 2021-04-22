import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/dashboard_navigator/dashboard_navigator.dart';
import 'theme/theme.dart';
import 'pages/landing.dart';
import 'pages/login.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

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
          case AppRoutes.DASHBOARD_PAGE:
            return MaterialPageRoute(
              builder: (context) => DashboardNavigator()
            );
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
  static const DASHBOARD_PAGE = 'dashboard_page';
}
