import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

import '../pages/grocery_list.dart';
import '../pages/receipe_list.dart';

class AppScaffold extends StatefulWidget {
  final bool showBottomNav;
  final bool showBackButton;
  final int bottomNavIndex;
  final Widget body;

  AppScaffold({
    Key key,
    @required this.body,
    this.showBottomNav = true,
    this.showBackButton = false,
    this.bottomNavIndex = 0,
  }) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int bottomNavIndex;

  @override
  void initState() {
    bottomNavIndex = widget.bottomNavIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      appBar: appBar(),
      bottomNavigationBar: widget.showBottomNav ? bottomNav() : null,
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text("Grocery App"),
      leading: widget.showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: [
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              GetIt.instance<AuthApiService>().logout(context);
            })
      ],
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      currentIndex: bottomNavIndex,
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
        switch (index) {
          case 0:
            if (bottomNavIndex != 0) {
              Navigator.pushReplacementNamed(context, GroceryListPage.route);
            }
            break;
          case 1:
            if (bottomNavIndex != 1) {
              Navigator.pushReplacementNamed(context, ReceipeListPage.route);
            }
            break;
          case 2:
            if (bottomNavIndex != 2) {
              // print('Not sure where this goes right now');
            }
            break;
        }
        bottomNavIndex = index;
        setState(() {});
      },
    );
  }
}
