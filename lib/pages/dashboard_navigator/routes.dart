import 'package:flutter/material.dart';

import '../../models/item_list.dart';
import 'dashboard_scaffold.dart';
import 'pages/add_grocery_list/add_grocery_list.dart';
import 'pages/grocery_list/grocery_list.dart';
import 'pages/receipe_list.dart';

class DashboardRouteDescriptors {
  final String routeName;
  final String label;
  final Widget icon;

  const DashboardRouteDescriptors({
    required this.routeName,
    required this.label,
    required this.icon,
  });
}

List<String> bottomNavRoutes = [
  DashboardScaffold.route,
  GroceryListPage.route,
  RecipeListPage.route,
  AddGroceryListPage.route,
];

class DashboardRoute extends MaterialPageRoute {
  final String routeName;
  DashboardRoute({
    required this.routeName,
    required super.builder,
    required super.settings,
  });

  @override
  Widget buildContent(BuildContext context) {
    return DashboardScaffold(
      activeRoute: routeName,
      child: super.buildContent(context),
    );
  }
}

DashboardRoute onGenerateDashboardRoutes(RouteSettings settings) {
  String bottomNavHighlightedRoute;
  WidgetBuilder builder;
  dynamic args = settings.arguments;
  if (settings.name == RecipeListPage.route) {
    bottomNavHighlightedRoute = RecipeListPage.route;
    builder = (context) => const RecipeListPage();
  } else if (settings.name == AddGroceryListPage.route) {
    ItemList? itemList;
    if (args is AddGroceryListPageArguments) {
      itemList = args.itemList;
    }
    bottomNavHighlightedRoute = GroceryListPage.route;
    builder = (context) => AddGroceryListPage(itemList: itemList);
  } else {
    bottomNavHighlightedRoute = GroceryListPage.route;
    builder = (context) => const GroceryListPage();
  }

  return DashboardRoute(
    routeName: bottomNavHighlightedRoute,
    builder: builder,
    settings: settings,
  );
}
