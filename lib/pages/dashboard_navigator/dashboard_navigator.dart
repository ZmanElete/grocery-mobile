import 'dart:developer';

import 'package:flutter/material.dart';

import '../../widget/app_bar.dart';
import 'routes.dart';

class DashboardNavigator extends StatefulWidget {
  static const route = 'dashboard_page';

  final String startingRoute;
  const DashboardNavigator({Key? key, this.startingRoute = DashboardRoutes.GROCERY_LISTS}) : super(key: key);

  @override
  DashboardNavigatorState createState() => DashboardNavigatorState();

  static DashboardNavigatorState of(BuildContext context) {
    final DashboardNavigatorState? result = context.findAncestorStateOfType<DashboardNavigatorState>();
    if (result != null) {
      return result;
    }
    throw FlutterError('HomePage.of() called with a context that does not contain a HomePage.');
  }
}

class DashboardNavigatorState extends State<DashboardNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => _navigatorKey.currentState!;

  String _startingRoute = DashboardRoutes.GROCERY_LISTS;
  String get _currentRoute => ModalRoute.of(context)?.settings.name ?? DashboardRoutes.GROCERY_LISTS;

  @override
  void initState() {
    _startingRoute = widget.startingRoute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GroceryAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          var nav = _navigatorKey.currentState;
          log("onWillPop", name: 'Dashboard Nav');
          if (nav?.canPop() ?? false) {
            _navigatorKey.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: _startingRoute,
          onGenerateRoute: onGenerateDashboardNavRoutes,
        ),
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      currentIndex: DashboardRoutes.indexOfRoute(_currentRoute),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Grocery Lists',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.healing),
          label: 'Stuff',
        ),
      ],
      onTap: (int index) {
        _navigatorKey.currentState?.pushReplacementNamed(
          DashboardRoutes.routeOfIndex(index),
        );
      },
    );
  }
}
