import 'package:flutter/material.dart';

import '../create/create_shipment_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  //bool? _obscurePassword;
  //bool? _autovalidate;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _phoneNumberController;

  @override
  void initState() {
    super.initState();
    //_obscurePassword = true;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Become SHIPPER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _regiterForm(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _regiterForm() {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //EMAIL AREA
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                isDense: true,
              ),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
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

            //PHONE NUMBER AREA
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone number',
                filled: true,
                isDense: true,
              ),
              obscureText: false,
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              //autocorrect: false,
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 17),
                ))
          ],
        ),
      ),
    );
  }
}
