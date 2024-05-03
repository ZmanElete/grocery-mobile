import 'package:flutter/material.dart';
import 'package:grocery_genie/consts.dart';
import 'package:grocery_genie/services/auth_api_service.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class GroceryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroceryAppBar({Key? key}) : super(key: key);

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'grocery-app-bar',
      child: AppBar(
        title: const Text(Constants.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Repository.instance.read(AuthApiService.key).logout(context);
            },
          )
        ],
      ),
    );
  }
}
