import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_list/pages/grocery_list.dart';
import 'package:grocery_list/pages/receipe_list.dart';

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
      onGenerateRoute:  (RouteSettings routeSettings){
        Map<String, dynamic> args = routeSettings.arguments;
        switch (routeSettings.name){
          case 'receipe_list':
            return MaterialPageRoute(builder: (context) => ReceipeList());
          case 'grocery_list':
            return MaterialPageRoute(builder: (context) => GroceryListPage());
          case 'login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          case 'landing':
          default:
            return MaterialPageRoute(builder: (context) => LandingPage());
        }
      },
    );
  }
}
