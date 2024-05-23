import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_genie/managers/session_manager.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/dashboard_scaffold.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/add_grocery_list/grocery_list_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/grocery_list/grocery_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/ingredient_detail/ingredient_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/ingredient_list/ingredient_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipe_detail/recipe_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipes_list/receipe_list.dart';
import 'package:grocery_genie/pages/landing.dart';
import 'package:grocery_genie/pages/login.dart';
import 'package:grocery_genie/pages/splash_page.dart';
import 'package:grocery_genie/utils/logging.dart';
import 'package:guru_provider/guru_provider/repository.dart';

enum AppRoute {
  splashPage(path: '/', name: 'Splash'),
  landingPage(path: '/landing', name: 'Landing'),
  loginPage(path: '/login', name: 'Login'),

  dashboard(path: '/app', name: 'Dashboard'),

  // Within Dashboard
  groceryListPage(path: '/groceries', name: 'Grocery List'),
  groceryListDetail(path: '/groceries/:id', name: 'Grocery List Detail'),

  recipeListPage(path: '/recipes', name: 'Recipe List'),
  recipeDetailPage(path: '/recipes/:id', name: 'Recipe Detail'),

  ingredientListPage(path: '/ingredients', name: 'Ingredient List'),
  ingredientDetailPage(path: '/ingredients/:id', name: 'Ingredient Detail');
  // Within Dashboard

  final String path;
  final String name;

  const AppRoute({
    required this.path,
    required this.name,
  });

  static AppRoute? fromName(String? name) {
    return values.where((e) => e.name == name).firstOrNull;
  }
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

const Logger logger = Logger('router');
final GoRouter router = GoRouter(
  initialLocation: AppRoute.splashPage.path,
  redirect: (context, state) {
    final session = Repository.instance.read(SessionManager.key);
    if (!session.loggedIn &&
        ![
          AppRoute.splashPage.path,
          AppRoute.landingPage.path,
        ].contains(state.fullPath)) {
      return AppRoute.landingPage.path;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoute.splashPage.path,
      name: AppRoute.splashPage.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: SplashPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.landingPage.path,
      name: AppRoute.landingPage.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: LandingPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.loginPage.path,
      name: AppRoute.loginPage.name,
      builder: (context, state) => LoginPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return DashboardScaffold(
          activeRoute: state.topRoute!.name!,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoute.dashboard.path,
          name: AppRoute.dashboard.name,
          redirect: (context, state) => AppRoute.dashboard.path + AppRoute.groceryListPage.path,
        ),
        //
        GoRoute(
            path: AppRoute.dashboard.path + AppRoute.groceryListPage.path,
            name: AppRoute.groceryListPage.name,
            pageBuilder: (context, state) {
              final page = GroceryListPage();
              final extra = state.extra;
              if (extra is Map && extra['fade'] == true) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: page,
                );
              }
              return NoTransitionPage(
                child: page,
              );
            }),
        GoRoute(
          path: AppRoute.dashboard.path + AppRoute.groceryListDetail.path,
          name: AppRoute.groceryListDetail.name,
          builder: (context, state) {
            final idString = state.pathParameters['id'];
            final id = idString == 'new' ? null : int.parse(idString!);
            final ItemList? extra = state.extra as ItemList?;
            return GroceryDetailListPage(id: id, itemList: extra,);
          },
          redirect: (context, state) {
            final groceryListPath = AppRoute.dashboard.path + AppRoute.groceryListPage.path;

            final idString = state.pathParameters['id'];
            if (idString == 'new') {
              return null;
            }

            final id = int.tryParse(idString.toString());
            if (id == null) {
              return groceryListPath;
            }

            return null;
          },
        ),
        //
        GoRoute(
            path: AppRoute.dashboard.path + AppRoute.recipeDetailPage.path,
            name: AppRoute.recipeDetailPage.name,
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return RecipeDetailPage(
                recipe: id,
              );
            }),
        GoRoute(
          path: AppRoute.dashboard.path + AppRoute.recipeListPage.path,
          name: AppRoute.recipeListPage.name,
          pageBuilder: (context, state) => NoTransitionPage(
            child: RecipeListPage(),
          ),
        ),
        //
        GoRoute(
          path: AppRoute.dashboard.path + AppRoute.ingredientListPage.path,
          name: AppRoute.ingredientListPage.name,
          pageBuilder: (context, state) => NoTransitionPage(
            child: IngredientListPage(),
          ),
        ),
        GoRoute(
          path: AppRoute.dashboard.path + AppRoute.ingredientDetailPage.path,
          name: AppRoute.ingredientDetailPage.name,
          builder: (context, state) => IngredientDetailPage(),
        ),
      ],
    )
  ],
);
