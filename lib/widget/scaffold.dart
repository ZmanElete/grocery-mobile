import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final bool showBottomNav;
  final bool showBackButton;
  final Widget body;

  AppScaffold({Key key, this.showBottomNav=true, this.showBackButton, this.body}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      appBar: appBar(),
      bottomNavigationBar:
      widget.showBottomNav
        ? Row(
            children: [
              IconButton(
                icon: Icon(Icons.assignment),
                onPressed: () => {
                  Navigator.pushReplacementNamed(context, 'grocery_list')
                }
              ),
              IconButton(
                icon: Icon(Icons.restaurant),
                onPressed: () => {
                  Navigator.pushReplacementNamed(context, 'receipe_list')
                }
              ),
            ],
          )
        : null,
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text("Grocery App"),
      leading:
        widget.showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : null,
    );
  }
}
