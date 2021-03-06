import 'package:flutter/material.dart';
import 'package:grocery_list/pages/grocery_list.dart';
import 'package:grocery_list/pages/receipe_list.dart';
import 'package:grocery_list/widget/app_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  _HomePageState of(BuildContext context, {bool nullOk = false}) {
    assert(nullOk != null);
    assert(context != null);
    final _HomePageState result = context.findAncestorStateOfType<_HomePageState>();
    if (nullOk || result != null) return result;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('HomePage.of() called with a context that does not contain a HomePage.'),
      ErrorDescription(
          'No HomePage ancestor could be found starting from the context that was passed to HomePage.of(). '
          'This usually happens when the context provided is from the same StatefulWidget as that '
          'whose build function actually creates the HomePage widget being sought.'),
      ErrorHint('There are several ways to avoid this problem. The simplest is to use a Builder to get a '
          'context that is "under" the HomePage. For an example of this, please see the '
          'documentation for HomePage.of():\n'
          '  https://api.flutter.dev/flutter/material/HomePage/of.html'),
      ErrorHint('A more efficient solution is to split your build function into several widgets. This '
          'introduces a new context from which you can obtain the HomePage. In this solution, '
          'you would have an outer widget that creates the HomePage populated by instances of '
          'your new inner widgets, and then in these inner widgets you would use HomePage.of().\n'
          'A less elegant but more expedient solution is assign a GlobalKey to the HomePage, '
          'then use the key.currentState property to obtain the HomePageState rather than '
          'using the HomePage.of() function.'),
      context.describeElement('The context used was')
    ]);
  }
}

class _HomePageState extends State<HomePage> {
  HomeRoutes _currentRoute = HomeRoutes.GROCERY_LIST;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GroceryAppBar(),
      body: Builder(builder: (context) => currentPage()),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget currentPage() {
    switch (_currentRoute) {
      case HomeRoutes.GROCERY_LIST:
        return GroceryListPage();
      case HomeRoutes.RECEIPE_LIST:
        return ReceipeListPage();
      default:
        return Container();
    }
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentRoute.index,
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
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.healing),
          label: 'Stuff',
        ),
      ],
      onTap: (int index) {
        changeRoute(HomeRoutes.values[index]);
      },
    );
  }

  changeRoute(HomeRoutes route) {
    _currentRoute = route;
    // switch (route) {
    //   case HomeRoutes.GROCERY_LIST:
    //     if (_currentRoute != HomeRoutes.GROCERY_LIST) {}
    //     break;
    //   case HomeRoutes.RECEIPE_LIST:
    //     if (_currentRoute != HomeRoutes.GROCERY_LIST) {}
    //     break;
    // }
    setState(() {});
  }
}

enum HomeRoutes {
  GROCERY_LIST,
  RECEIPE_LIST,
}
