//import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/constant.dart';
import '../../models/response_options.dart';

class DataServices {
  final baseUrl = 'http://localhost:8000/api/v1';

  Future<OptionsResponse?> getListOfCommodities() async {
    var url = Uri.parse('${Constants.apiUrl}lookups/commodities/');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    final data = OptionsResponse.fromRawJson(response.body);
    return data;
  }
}
