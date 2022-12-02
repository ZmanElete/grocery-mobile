import 'dart:developer';

import 'package:flutter/material.dart';

import '/widget/app_bar.dart';
import 'pages/grocery_list/grocery_list.dart';
import 'pages/receipe_list.dart';
import 'routes.dart';

const List<DashboardRouteDescriptors> dashboardBottomNavDescriptors = [
  DashboardRouteDescriptors(
    routeName: GroceryListPage.route,
    label: 'Grocery Lists',
    icon: Icon(Icons.assignment),
  ),
  DashboardRouteDescriptors(
    routeName: RecipeListPage.route,
    label: 'Recipes',
    icon: Icon(Icons.restaurant),
  ),
  DashboardRouteDescriptors(
    routeName: 'un attainable right now.',
    label: 'Stuff',
    icon: Icon(Icons.healing),
  ),
];

class DashboardScaffold extends StatefulWidget {
  static const route = 'dashboard_page';

  final String activeRoute;
  final Widget child;
  const DashboardScaffold({
    super.key,
    required this.activeRoute,
    required this.child,
  });

  @override
  DashboardScaffoldState createState() => DashboardScaffoldState();

  static DashboardScaffoldState of(BuildContext context) {
    final DashboardScaffoldState? result = context.findAncestorStateOfType<DashboardScaffoldState>();
    if (result != null) {
      return result;
    }
    throw FlutterError('HomePage.of() called with a context that does not contain a HomePage.');
  }
}

class DashboardScaffoldState extends State<DashboardScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GroceryAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          log("onWillPop", name: 'Dashboard Scaffold');
          return true;
        },
        child: widget.child,
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return Hero(
      tag: 'dashboard-scaffold-bottom-nav',
      child: BottomNavigationBar(
        currentIndex: dashboardBottomNavDescriptors.indexWhere(
          (element) => element.routeName == widget.activeRoute,
        ),
        items: [
          for (final route in dashboardBottomNavDescriptors)
            BottomNavigationBarItem(
              icon: route.icon,
              label: route.label,
            ),
        ],
        onTap: (int index) {
          final route = dashboardBottomNavDescriptors[index];
          Navigator.of(context).pushReplacementNamed(route.routeName);
        },
      ),
    );
  }
}
