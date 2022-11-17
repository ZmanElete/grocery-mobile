import 'package:flutter/material.dart';

import 'dashboard_navigator/dashboard_navigator.dart';
import 'landing.dart';
import 'login.dart';

Route<dynamic> onGenerateBaseRoutes(RouteSettings routeSettings) {
  // Map<String, dynamic> args = routeSettings.arguments;
  switch (routeSettings.name) {
    case LoginPage.route:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case DashboardNavigator.route:
      return MaterialPageRoute(builder: (context) => const DashboardNavigator());
    case LandingPage.route:
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
