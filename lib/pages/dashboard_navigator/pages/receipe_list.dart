import 'package:flutter/material.dart';

class RecipeListPage extends StatefulWidget {
  RecipeListPage({Key? key}) : super(key: key);

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Recipes'),
    );
  }
}
