import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routenName = '/login';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LoginPage(),
        settings: const RouteSettings(name: routenName));
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  //bool? _obscurePassword;
  //bool? _autovalidate;
  TextEditingController? _username;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    //_obscurePassword = true;
    _username = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Login Page'),
        backgroundColor: const Color.fromRGBO(37, 59, 128, 5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _LoginForm(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _LoginForm() {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //USERNAME AREA
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'username',
                filled: true,
                isDense: true,
              ),
              controller: _username,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),
            const SizedBox(
              height: 12,
            ),

            //PASSWORD AREA
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                filled: true,
                isDense: true,
              ),
              obscureText: true,
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              //autocorrect: false,
            ),

            const SizedBox(
              height: 12,
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
