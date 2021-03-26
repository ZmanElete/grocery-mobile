import 'package:flutter/material.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

import '../app.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO - check for login creds
    autoLogin(context);
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
              child: RaisedButton(
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
    print(authService);
    bool valid = await authService.verifyAccessToken();
    if (valid) {
      Navigator.pushReplacementNamed(context, AppRoutes.HOME_PAGE);
    }
  }
}
