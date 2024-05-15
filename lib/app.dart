import 'package:flutter/material.dart';

import 'package:grocery_genie/consts.dart';
import 'package:grocery_genie/pages/routes.dart';
import 'package:grocery_genie/pages/splash_page.dart';
import 'package:grocery_genie/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Constants.appName,
      theme: AppTheme.getTheme(Brightness.light),
      darkTheme: AppTheme.getTheme(Brightness.dark),
      
      initialRoute: SplashPage.route,
      onGenerateRoute: onGenerateBaseRoutes,
    );
  }
}
