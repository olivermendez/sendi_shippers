import 'package:flutter/material.dart';
import 'package:my_app/src/pages/page_seleted_index.dart';
import 'package:my_app/src/pages/welcome_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomePage.routeName,
      routes: {
        '/welcome': (_) => const WelcomePage(),
      },
    );
  }
}
