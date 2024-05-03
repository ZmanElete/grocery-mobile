import 'package:flutter/material.dart';
import 'package:grocery_genie/helpers/http_helpers.dart';
import 'package:grocery_genie/managers/session_manager.dart';
import 'package:grocery_genie/models/config.dart';
import 'package:grocery_genie/pages/dashboard_navigator/dashboard_scaffold.dart';
import 'package:grocery_genie/services/auth_api_service.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class LoginPage extends StatefulWidget {
  static const route = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Config config = Config.instance;
  AuthApiService auth = Repository.instance.read(AuthApiService.key);
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
      appBar: AppBar(),
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
                const SizedBox(height: 40),
                TextFormField(
                  controller: emailController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must Enter Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.key),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Must Enter Username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
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
      final email = emailController.text;
      final password = passwordController.text;
      try {
        await SessionManager.instance.login(email: email, password: password);
        Navigator.pushNamedAndRemoveUntil(
          context,
          DashboardScaffold.route,
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
