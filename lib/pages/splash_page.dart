// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/session_manager.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/grocery_list/grocery_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/routes.dart';
import 'package:grocery_genie/pages/landing.dart';
import 'package:grocery_genie/services/auth_api_service.dart';
import 'package:grocery_genie/services/prefs.dart';
import 'package:grocery_genie/widget/logo.dart';
import 'package:guru_provider/guru_provider/repository.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  static const String route = 'splash';
  const SplashPage({super.key});

  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // The page we go to after the splash page is determined by whether we are authenticated
    // And whether we have recorded that the setup process has been completed.
    Widget initialPage = const LandingPage();

    final prefs = await Repository.instance.read(prefsKey);
    final token = prefs.getString(AuthApiService.ACCESS_TOKEN_KEY);
    if (token != null) {
      final loggedIn = await Repository.instance.read(SessionManager.key).autoLogin();
      if (loggedIn) {
        initialPage = DashboardRoute(
          routeName: GroceryListPage.route,
          builder: (context) => const GroceryListPage(),
          settings: null,
        ).buildContent(context);
      }
    }

    Navigator.of(context).pushReplacement(
      PageTransition(
        duration: const Duration(milliseconds: 800),
        reverseDuration: const Duration(milliseconds: 800),
        type: PageTransitionType.fade,
        child: initialPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeApp(context);
    return const Material(
      child: Center(
        child: Hero(
          tag: 'logo',
          child: Logo(),
        ),
      ),
    );
  }
}
