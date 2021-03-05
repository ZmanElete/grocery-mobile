import 'package:flutter/material.dart';
import 'package:grocery_list/models/config.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

class LoginPage extends StatefulWidget {
  static const route = 'login';
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Config config;
  AuthApiService auth;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    config = Config.instance;
    auth = AuthApiService.instance;
    emailController = TextEditingController(
      text: config.debug ? config.debugLoginEmail ?? '' : '',
    );
    passwordController = TextEditingController(
      text: config.debug ? config.debugLoginPassword ?? '' : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
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
                            if (value.isEmpty) {
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
                            if (value.isEmpty) {
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
                          onPressed: () => login(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(context) async {
    if (formKey.currentState.validate()) {
      var email = emailController.text;
      var password = passwordController.text;
      var successful = await auth.login(email: email, password: password);
      if (successful) {
        Navigator.pushReplacementNamed(context, 'grocery_list');
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Login Credentials '),
          ),
        );
      }
    }
  }
}
