import 'package:flutter/material.dart';
import 'package:grocery_list/pages/grocery_list.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

class LandingPage extends StatelessWidget {
  static const route = 'landing';
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO - check for login creds
    autoLogin(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text("Grocery App"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void autoLogin(context) async {
    var authService = AuthApiService.instance;
    print(authService);
    bool valid = await authService.verifyAccessToken();
    if (valid) {
      Navigator.pushReplacementNamed(context, GroceryListPage.route);
    }
  }
}
