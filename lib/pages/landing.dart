import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:grocery_genie/consts.dart';
import 'package:grocery_genie/pages/login.dart';
import 'package:grocery_genie/widget/logo.dart';
import 'package:page_transition/page_transition.dart';

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
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: 'logo',
                  child: Logo(),
                ),
                Center(
                  child: Text(
                    Constants.appName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 60),
            alignment: Alignment.center,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                    type: PageTransitionType.fade,
                    child: LoginPage(),
                  ),
                );
              },
              child: const Text(
                'Login',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
