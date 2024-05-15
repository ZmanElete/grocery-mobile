import 'package:flutter/material.dart';
import 'package:grocery_genie/pages/splash_page.dart';

import 'package:grocery_genie/pages/dashboard_navigator/routes.dart';
import 'package:grocery_genie/pages/landing.dart';
import 'package:grocery_genie/pages/login.dart';


Route<dynamic> onGenerateBaseRoutes(RouteSettings settings) {
  // Map<String, dynamic> args = routeSettings.arguments;
  WidgetBuilder builder;
  if (settings.name == LoginPage.route) {
    builder = (context) => const LoginPage();
  } else if (bottomNavRoutes.contains(settings.name)) {
    return onGenerateDashboardRoutes(settings);
  } else if (settings.name == SplashPage.route) {
    builder = (context) => const SplashPage();
  } else {
    builder = (context) => const LandingPage();
  }

  return MaterialPageRoute(builder: builder, settings: settings);
}
