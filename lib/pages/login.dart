import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_list/models/config.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final sl = GetIt.instance;
  Config config;
  AuthApiService auth;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    config = sl<Config>();
    auth = sl<AuthApiService>();
    emailController = TextEditingController(
      text: config.debug
        ? config.debugLoginEmail ?? ''
        : '',
    );
    passwordController = TextEditingController(
      text: config.debug
        ? config.debugLoginPassword ?? ''
        : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Container(
              height: 400,
              padding: EdgeInsets.all(40),
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Must Enter Email';
                        }
                        return null;
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      controller: emailController,
                    ),
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Must Enter Username';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      controller: passwordController,
                    ),
                    RaisedButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          var email = emailController.toString();
                          var password = passwordController.toString();
                          auth.login(email: email, password: password);
                          Navigator.pushReplacementNamed(context, 'home');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
