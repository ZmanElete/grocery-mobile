import 'package:flutter/material.dart';

import 'pages/routes.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: AppTheme.theme,
      initialRoute: 'landing',
      onGenerateRoute: onGenerateBaseRoutes,
    );
  }
}
