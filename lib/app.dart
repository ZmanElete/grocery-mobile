import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_list/pages/grocery_list.dart';
import 'package:grocery_list/pages/receipe_list.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';
import 'package:grocery_list/services/dio_service.dart';

import 'pages/grocery_list.dart';
import 'pages/receipe_list.dart';
import 'theme/theme.dart';

import 'pages/landing.dart';
import 'pages/login.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: AppTheme.theme,
      initialRoute: 'landing',
      onGenerateRoute: (RouteSettings routeSettings) {
        Map<String, dynamic> args = routeSettings.arguments;
        switch (routeSettings.name) {
          case ReceipeListPage.route:
            return MaterialPageRoute(builder: (context) => ReceipeListPage());
          case GroceryListPage.route:
            return MaterialPageRoute(builder: (context) => GroceryListPage());
          case LoginPage.route:
            return MaterialPageRoute(builder: (context) => LoginPage());
          case LandingPage.route:
          default:
            return MaterialPageRoute(builder: (context) => LandingPage());
        }
      },
    );
  }
}
