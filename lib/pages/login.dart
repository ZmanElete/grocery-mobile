import 'package:flutter/material.dart';
import 'package:grocery_list/app.dart';
import 'package:grocery_list/models/config.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Config config = Config.instance;
  AuthApiService auth = AuthApiService.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = config.debug ? config.debugLoginEmail ?? '' : '';
    passwordController.text =
        config.debug ? config.debugLoginPassword ?? '' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
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
                  height: 300,
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
                            if (value == null || value.isEmpty) {
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
                            if (value == null || value.isEmpty) {
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
                        ElevatedButton(
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
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      var email = emailController.text;
      var password = passwordController.text;
      try {
        await auth.login(email: email, password: password);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.DASHBOARD_PAGE,
          (_) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Login Credentials '),
          ),
        );
      }
    }
  }
}
