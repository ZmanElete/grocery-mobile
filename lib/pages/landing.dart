import 'package:flutter/material.dart';

import 'package:grocery_genie/consts.dart';
import 'package:grocery_genie/pages/login.dart';
import 'package:grocery_genie/widget/logo.dart';

class LandingPage extends StatelessWidget {
  static const route = 'landing_page';

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Hero(
                  tag: 'logo',
                  child: Logo(),
                ),
                Center(
                  child: Text(
                    Constants.appName,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 45),
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
}
