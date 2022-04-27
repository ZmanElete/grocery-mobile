import 'package:flutter/material.dart';
import 'package:grocery_list/managers/session_manager.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';
import 'package:grocery_list/services/service_locator.dart';

import '../app.dart';

class LandingPage extends StatelessWidget {
  final prefs = ServiceLocator.prefs;

  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var token = prefs.getString(AuthApiService.ACCESS_TOKEN_KEY);
    if (token != null) autoLogin(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Grocery App",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
                },
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void autoLogin(context) async {
    var authService = AuthApiService.instance;
    bool success = false;
    success = await SessionManager.instance.autoLogin();
    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.DASHBOARD_PAGE);
    }
  }
}
