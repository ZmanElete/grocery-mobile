import 'package:flutter/material.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

class GroceryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroceryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'grocery-app-bar',
      child: AppBar(
        title: const Text("Grocery App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              AuthApiService.instance.logout(context);
            },
          )
        ],
      ),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
