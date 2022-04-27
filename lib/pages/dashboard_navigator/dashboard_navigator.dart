import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/grocery_list/add_grocery_list.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/grocery_list/grocery_list.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/receipe_list.dart';
import 'package:grocery_list/widget/app_bar.dart';

class DashboardNavigator extends StatefulWidget {
  final String startingRoute;
  DashboardNavigator({Key? key, this.startingRoute = DashboardRoutes.GROCERY_LISTS})
      : super(key: key);

  @override
  _DashboardNavigatorState createState() => _DashboardNavigatorState();

  static _DashboardNavigatorState of(BuildContext context) {
    final _DashboardNavigatorState? result =
        context.findAncestorStateOfType<_DashboardNavigatorState>();
    if (result != null) {
      return result;
    }
    throw FlutterError('HomePage.of() called with a context that does not contain a HomePage.');
  }
}

class _DashboardNavigatorState extends State<DashboardNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => _navigatorKey.currentState!;

  String _startingRoute = DashboardRoutes.GROCERY_LISTS;
  late String _currentRoute;

  @override
  void initState() {
    _startingRoute = widget.startingRoute;
    _currentRoute = _startingRoute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GroceryAppBar(),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: _startingRoute,
        onGenerateRoute: onGenerateRoute,
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    log("Navigating to '${settings.name}'", name: "Dashboard Navigator");
    late Widget page;
    switch (settings.name) {
      case DashboardRoutes.ADD_GROCERY_LIST:
        page = AddGroceryListPage();
        break;
      case DashboardRoutes.RECIPES:
        page = RecipeListPage();
        break;
      case DashboardRoutes.GROCERY_LISTS:
      default:
        page = GroceryListPage();
    }

    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      currentIndex: DashboardRoutes.indexOfRoute(_currentRoute),
      //TODO USE THEME
      selectedItemColor: Color(0xFFFF9375),
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.grey[900],
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Grocery Lists',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.healing),
          label: 'Stuff',
        ),
      ],
      onTap: (int index) {
        changeRoute(DashboardRoutes.routeOfIndex(index));
      },
    );
  }

  changeRoute(String route) {
    _currentRoute = route;
    _navigatorKey.currentState?.pushReplacementNamed(route);
  }
}

class DashboardRoutes {
  static const GROCERY_LISTS = 'grocery_lists';
  static const ADD_GROCERY_LIST = 'add_grocery_list';
  static const RECIPES = 'recipes';

  static int indexOfRoute(String route) {
    switch (route) {
      case ADD_GROCERY_LIST:
      case GROCERY_LISTS:
        return 0;
      case RECIPES:
        return 1;
    }
    return 0;
  }

  static String routeOfIndex(int index) {
    switch (index) {
      case 0:
        return GROCERY_LISTS;
      case 1:
        return RECIPES;
    }
    return GROCERY_LISTS;
  }
}
