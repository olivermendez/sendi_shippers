import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/providers/menu_commodities.dart';
import 'package:my_app/src/utils/icons_string_util.dart';
//import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const HomePage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          
          elevation: 0,
          title: const Text(
            'Que quieres enviar?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromRGBO(37, 59, 128, 5),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 236, 20),
        body: _listaItem(),
      ),
    );
  }

  Widget _listaItem() {
    return FutureBuilder(
        future: menuProvider.cargarData(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: options(snapshot.data),
          );
        });
  }

  List<Widget> options(List<dynamic>? data) {
    final List<Widget> opciones = [];

    data?.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['label']),
        leading: getIcon(opt['icon'].toString()),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.pushNamed(context, opt['route'].toString());
        },
      );

      opciones
        ..add(widgetTemp)
        ..add(const Divider());
    });

    return opciones;
  }
}
