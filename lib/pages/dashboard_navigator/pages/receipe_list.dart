import 'package:flutter/material.dart';

class RecipeListPage extends StatefulWidget {
  static const String route = 'recipe-list';
  const RecipeListPage({Key? key}) : super(key: key);

  @override
  RecipeListPageState createState() => RecipeListPageState();
}

class RecipeListPageState extends State<RecipeListPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('Recipes');
  }
}
