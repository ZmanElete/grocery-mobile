import 'dart:developer';

import 'package:flutter/material.dart';

import 'pages/add_grocery_list/add_grocery_list.dart';
import 'pages/grocery_list/grocery_list.dart';
import 'pages/receipe_list.dart';


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


Route onGenerateDashboardNavRoutes(RouteSettings settings) {
    log("Navigating to '${settings.name}'", name: "Dashboard Navigator");
    late Widget page;
    switch (settings.name) {
      case DashboardRoutes.ADD_GROCERY_LIST:
        page = const AddGroceryListPage();
        break;
      case DashboardRoutes.RECIPES:
        page = const RecipeListPage();
        break;
      case DashboardRoutes.GROCERY_LISTS:
      default:
        page = const GroceryListPage();
    }

    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }
