import 'dart:math';

import 'package:flutter/material.dart';

class ExpandingItem extends StatefulWidget {
  final EdgeInsets padding;
  final double height;
  final double width;
  final Widget child;
  final Widget target;

  ExpandingItem({
    Key key,
    this.padding = const EdgeInsets.all(30),
    this.height = 80,
    this.width,
    @required this.child,
    @required this.target,
  }) : super(key: key);

  @override
  _ExpandingItemState createState() => _ExpandingItemState();
}

class _ExpandingItemState extends State<ExpandingItem> {
  bool expanded = false;
  EdgeInsets get padding => expanded ? EdgeInsets.zero : widget.padding;
  double get height => expanded ? MediaQuery.of(context).size.height : widget.height;
  double get width => expanded ? MediaQuery.of(context).size.width : widget.width;
  Widget get child => expanded ? widget.target : widget.child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: GestureDetector(
          onTap: () {
            expanded = !expanded;
            setState(() {});
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: padding,
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}
