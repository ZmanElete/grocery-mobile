// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_genie/managers/session_manager.dart';
import 'package:grocery_genie/router.dart';
import 'package:grocery_genie/services/auth_api_service.dart';
import 'package:grocery_genie/services/prefs.dart';
import 'package:grocery_genie/widget/logo.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class SplashPage extends StatelessWidget {
  static const String route = 'splash';
  const SplashPage({super.key});

  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // The page we go to after the splash page is determined by whether we are authenticated
    // And whether we have recorded that the setup process has been completed.
    AppRoute initialPage = AppRoute.landingPage;

    final prefs = await Repository.instance.read(prefsKey);
    final token = prefs.getString(AuthApiService.ACCESS_TOKEN_KEY);
    if (token != null) {
      final loggedIn = await Repository.instance.read(SessionManager.key).autoLogin();
      if (loggedIn) {
        initialPage = AppRoute.groceryListPage;
      }
    }

    GoRouter.of(context).goNamed(initialPage.name, extra: {'fade': true});
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
