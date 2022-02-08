import 'package:flutter/material.dart';
import 'package:my_app/src/pages/home.dart';
import 'package:my_app/src/pages/opt_verification_page.dart';
import 'package:my_app/src/pages/register_page.dart';
import 'package:my_app/src/pages/welcome_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(3, 9, 23, 1),
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: Color.fromRGBO(3, 9, 23, 1),
            textTheme: ButtonTextTheme.primary,
          )),
      initialRoute: WelcomePage.routeName,
      routes: {
        '/welcome': (_) => const WelcomePage(),
        'home': (_) => const Home(),
        'register': (_) => const RegisterPage(),
        'opt-verify': (_) => OPTVerification(),
      },
    );
  }
}
