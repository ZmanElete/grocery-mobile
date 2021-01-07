import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO - check for login creds
    Navigator.pushReplacementNamed(context, 'login');
    return Container(
      child: Container(
        child: Text("Grocery App"),
      ),
    );
  }
}
