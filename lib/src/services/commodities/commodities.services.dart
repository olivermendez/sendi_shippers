import 'package:my_app/config/constant.dart';
import 'package:my_app/models/response_options.dart';
import 'package:http/http.dart' as http;

class ServicesApi {
  Future<OptionsResponse?> getData() async {
    var url = Uri.parse('${Constants.apiUrl}lookups/commodities/');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    final nowListingResponse = OptionsResponse.fromRawJson(response.body);
    return nowListingResponse;
  }
}
