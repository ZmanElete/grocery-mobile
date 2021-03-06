import 'package:flutter/material.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

class GroceryAppBar extends StatelessWidget implements PreferredSizeWidget {
  GroceryAppBar({Key? key}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text("Grocery App"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            AuthApiService.instance.logout(context);
          },
        )
      ],
    );
  }

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);
}
