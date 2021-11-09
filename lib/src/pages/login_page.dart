import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/home.dart';

import 'createshipment.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _rememberme = true;
  bool? _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
    //_obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Login Page'),
        backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
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
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //EMAIL AREA
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Insert your email',
                prefixIcon: Icon(Icons.alternate_email),
                filled: true,
                isDense: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                } else if (!EmailValidator.validate(_email!)) {
                  return "Please enter valid email";
                }
                return null;
              },
              //controller: _emailController,
              onChanged: (value) {
                _email = value;
              },
              //controller: _emailController,
              autocorrect: false,
            ),
            const SizedBox(
              height: 12,
            ),

            //PASSWORD AREA
            TextFormField(
              decoration: InputDecoration(
                //labelText: 'Password',
                hintText: "Insert your password",
                filled: true,
                isDense: true,
                prefixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible!
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible!;
                      });
                    }),
                //suffixIcon: const Icon(Icons.account_box),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
              onChanged: (value) {
                _password = value;
              },
              obscureText: !_passwordVisible!,
              //controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              //autocorrect: false,
            ),

            const SizedBox(
              height: 12,
            ),

            CheckboxListTile(
                title: const Text("Remember me"),
                value: _rememberme,
                onChanged: (value) {
                  setState(() {
                    _rememberme = value!;
                  });
                }),

            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Logged"),
                      backgroundColor: Colors.green,
                    ));
                  }
                },
                child: const Text("Login Now")),
            const SizedBox(
              height: 10,
            ),

            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'opt-verify');
                },
                child: const Text("Are you new user ?, Register Now"))
          ],
        ),
      ),
    );
  }

  void login() async {
    Map<String, dynamic> request = {"email": _email, "password": _password};

    var url = Uri.parse('${Constants.apiUrl}auth/login');

    var response = await http.post(
      url,
      body: jsonEncode(request),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    var body = response.body;
    var decodedJson = jsonDecode(body);
    var token = Token.fromJson(decodedJson);

    Navigator.pushNamed(context, 'home', arguments: token);
  }
}
