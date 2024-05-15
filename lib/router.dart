import 'package:go_router/go_router.dart';
import 'package:grocery_genie/managers/session_manager.dart';
import 'package:grocery_genie/utils/logging.dart';
import 'package:guru_provider/guru_provider/repository.dart';

enum AppRoute {
  splashPage(path: '/', name: 'Splash'),
  landingPage(path: '/landing', name: 'Landing'),
  loginPage(path: '/login', name: 'Login'),

  groceryListPage(path: '/groceries', name: 'Grocery List'),
  groceryListDetail(path: '/groceries/:id', name: 'Grocery List Detail'),

  recipeListPage(path: '/recipes', name: 'Recipe List'),
  recipeDetailPage(path: '/recipes/:id', name: 'Recipe Detail'),

  ingredientListPage(path: '/ingredients', name: 'Ingredient List'),
  ingredientDetailPage(path: '/ingredients/:id', name: 'Ingredient Detail');

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

const Logger logger = Logger('router');
final GoRouter router = GoRouter(
  initialLocation: AppRoute.splashPage.path,
  redirect: (context, state) {
    final session = Repository.instance.read(SessionManager.key);
    if (session.loggedIn) {
      return AppRoute.landingPage.path;
    }
  },
  routes: [],
);
