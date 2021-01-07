import 'package:flutter/material.dart';
import 'package:grocery_list/widget/scaffold.dart';

class ReceipeList extends StatefulWidget {
  ReceipeList({Key key}) : super(key: key);

  @override
  _ReceipeListState createState() => _ReceipeListState();
}

class _ReceipeListState extends State<ReceipeList> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(),
      showBackButton: false,
      showBottomNav: true,
    );
  }
}
