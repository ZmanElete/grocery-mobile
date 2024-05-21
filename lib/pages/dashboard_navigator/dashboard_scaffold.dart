import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_genie/pages/dashboard_navigator/routes.dart';
import 'package:grocery_genie/router.dart';
import 'package:grocery_genie/widget/app_bar.dart';

final bottomNavKey = GlobalKey();

const List<DashboardRouteDescriptors> dashboardBottomNavDescriptors = [
  DashboardRouteDescriptors(
    routes: [
      AppRoute.groceryListPage,
      AppRoute.groceryListDetail,
    ],
    destinationRoute: AppRoute.groceryListPage,
    label: 'Grocery Lists',
    selectedIcon: Icon(Icons.shopping_cart),
    icon: Icon(Icons.shopping_cart_outlined),
  ),
  DashboardRouteDescriptors(
    routes: [
      AppRoute.recipeListPage,
      AppRoute.recipeDetailPage,
    ],
    destinationRoute: AppRoute.recipeListPage,
    label: 'Recipes',
    selectedIcon: Icon(Icons.book),
    icon: Icon(Icons.book_outlined),
  ),
  DashboardRouteDescriptors(
    routes: [
      AppRoute.ingredientListPage,
      AppRoute.ingredientDetailPage,
    ],
    destinationRoute: AppRoute.ingredientListPage,
    label: 'Ingredients',
    selectedIcon: Icon(Icons.egg),
    icon: Icon(Icons.egg_outlined),
    // icon: Icon(Icons.cookie),
    // icon: Icon(Icons.egg_alt),
    // icon: Icon(Icons.nutrition),
  ),
  // DashboardRouteDescriptors(
  //   routeName: IngredientListPage.route,
  //   label: 'Tags',
  //   icon: Icon(Icons.tag),
  // ),
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
    final DashboardScaffoldState? result =
        context.findAncestorStateOfType<DashboardScaffoldState>();
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
      child: NavigationBar(
        key: bottomNavKey,
        destinations: [
          for (final route in dashboardBottomNavDescriptors)
            NavigationDestination(
              label: route.label,
              selectedIcon: route.selectedIcon,
              icon: route.icon,
            ),
        ],
        selectedIndex: dashboardBottomNavDescriptors.indexWhere(
          (element) => element.routes.any((e) => e.name == widget.activeRoute),
        ),
        onDestinationSelected: (int index) {
          final route = dashboardBottomNavDescriptors[index];
          if (route.destinationRoute.name != widget.activeRoute) {
            GoRouter.of(context).goNamed(route.destinationRoute.name);
          }
        },
      ),
    );
  }
}
