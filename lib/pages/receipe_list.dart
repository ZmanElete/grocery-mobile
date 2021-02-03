import 'package:flutter/material.dart';
import 'package:grocery_list/widget/scaffold.dart';

class ReceipeListPage extends StatefulWidget {
  static const route = 'receipe_list';
  ReceipeListPage({Key key}) : super(key: key);

  @override
  _ReceipeListPageState createState() => _ReceipeListPageState();
}

class _ReceipeListPageState extends State<ReceipeListPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(),
      showBackButton: false,
      showBottomNav: true,
    );
  }
}
