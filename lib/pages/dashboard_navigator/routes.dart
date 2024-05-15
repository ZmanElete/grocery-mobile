import 'package:flutter/material.dart';
import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/dashboard_scaffold.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/add_grocery_list/add_grocery_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/grocery_list/grocery_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/ingredient_detail/ingredient_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/ingredient_list/ingredient_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipe_detail/recipe_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipes_list/receipe_list.dart';

class DashboardRouteDescriptors {
  final String routeName;
  final String label;
  final Widget selectedIcon;
  final Widget icon;

  const DashboardRouteDescriptors({
    required this.routeName,
    required this.label,
    required this.selectedIcon,
    required this.icon,
  });
}

const List<String> bottomNavRoutes = [
  DashboardScaffold.route,
  GroceryListPage.route,
  RecipeListPage.route,
  AddGroceryListPage.route,
  RecipeDetailPage.route,
  IngredientListPage.route,
  IngredientDetailPage.route,
];

final scaffoldKey = GlobalKey<DashboardScaffoldState>();

class DashboardRoute extends MaterialPageRoute {
  final String routeName;
  final Widget? floatingActionButton;

  DashboardRoute({
    required this.routeName,
    required super.builder,
    required super.settings,
    this.floatingActionButton,
  });

  @override
  Widget buildContent(BuildContext context) {
    return DashboardScaffold(
      key: scaffoldKey,
      activeRoute: routeName,
      child: super.buildContent(context),
    );
  }
}

DashboardRoute onGenerateDashboardRoutes(RouteSettings settings) {
  String bottomNavHighlightedRoute;
  WidgetBuilder builder;
  final dynamic args = settings.arguments;
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
  } else if (settings.name == RecipeDetailPage.route) {
    if (args is! RecipeDetailPageArgs) {
      throw Exception('Recipe must be passed in. (create an empty one if you must)');
    }
    bottomNavHighlightedRoute = RecipeListPage.route;
    builder = (context) => RecipeDetailPage(
          recipe: args.recipe,
          editing: args.editing,
        );
  } else if (settings.name == IngredientListPage.route) {
    bottomNavHighlightedRoute = IngredientListPage.route;
    builder = (context) => const IngredientListPage();
  } else if (settings.name == IngredientDetailPage.route) {
    bottomNavHighlightedRoute = IngredientListPage.route;
    Ingredient? ingredient;
    bool? editing;
    if (args is IngredientDetailPageArgs) {
      ingredient = args.ingredient;
      editing = args.editing;
    }
    builder = (context) => IngredientDetailPage(
      ingredient: ingredient,
      editing: editing,
    );
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
