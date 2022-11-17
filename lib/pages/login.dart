import 'package:flutter/material.dart';
import 'package:grocery_list/helpers/http_helpers.dart';
import 'package:grocery_list/managers/session_manager.dart';
import 'package:grocery_list/models/config.dart';
import 'package:grocery_list/pages/dashboard_navigator/dashboard_navigator.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';

class LoginPage extends StatefulWidget {
  static const route = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Config config = Config.instance;
  AuthApiService auth = AuthApiService.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = config.debug ? config.debugLoginEmail ?? '' : '';
    passwordController.text = config.debug ? config.debugLoginPassword ?? '' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Builder(
        builder: (context) => Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must Enter Email';
                    }
                    return null;
                  },
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must Enter Username';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  controller: passwordController,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () => login(context),
                ),
              ],
            ),
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
        await SessionManager.instance.login(email: email, password: password);
        Navigator.pushNamedAndRemoveUntil(
          context,
          DashboardNavigator.route,
          (_) => false,
        );
      } on HttpNotAuthorized {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Login Credentials '),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Something went wrong with the request. Try again later.',
            ),
          ),
        );
      }
    }
  }
}
