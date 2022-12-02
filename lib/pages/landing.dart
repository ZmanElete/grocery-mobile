import 'package:flutter/material.dart';

import '/managers/session_manager.dart';
import '/services/api/auth_api_service.dart';
import '/services/service_locator.dart';
import 'dashboard_navigator/dashboard_scaffold.dart';
import 'login.dart';

class LandingPage extends StatelessWidget {
  static const route = 'landing_page';

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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.route);
                },
                child: const Text(
                  'Login',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void autoLogin(context) async {
    bool success = false;
    success = await SessionManager.instance.autoLogin();
    if (success) {
      Navigator.pushReplacementNamed(context, DashboardScaffold.route);
    }
  }
}
