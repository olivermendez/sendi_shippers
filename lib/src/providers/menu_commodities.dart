import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _MenuProvider {
  List<dynamic> opciones = [];

  _MenuProvider() {
    cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    final response = await rootBundle.loadString('data/options.json');

    Map dataMap = json.decode(response);
    opciones = dataMap['options'];

    return opciones;
  }
}

final menuProvider = _MenuProvider();
