import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/domain/entities/models/commodities/motor_bodytypes_model.dart';
import 'package:my_app/domain/entities/models/commodities/vehicles_bodytypes_model.dart';
import 'package:my_app/domain/repositories/commodities_repository.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/infraestructure/errors/errors.dart';

class Constants {
  static String get apiUrl => 'http://localhost:8000/api/v1/';
}

class CommoditiesApi extends CommoditiesRepository {
  @override
  Future<List<CommodityDetails>> getCommodities() async {
    var url = Uri.parse('${Constants.apiUrl}lookups/commodities/');

    final response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final commoditiesResponse = commoditiesResponseFromJson(response.body);
      final commodities = commoditiesResponse.options.commodities;
      return commodities;
    } else {
      throw ApiErrors();
    }
  }

  @override
  Future<List<MotorBodytypeDetail>> getMotorBodyTypes() async {
    var url = Uri.parse('${Constants.apiUrl}motor/bodytypes');

    final response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final resp = MotorBodyTypeResponse.fromRawJson(response.body);
      final data = resp.options.bodytypes;
      return data;
    } else {
      throw ApiErrors();
    }

    //throw UnimplementedError();
  }

  @override
  Future<List<VehicleBodytypeDetail>> getVehicleBodyTypes() async {
    var url = Uri.parse('${Constants.apiUrl}vehicle/bodytypes');

    final response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final resp = VehicleBodyTypeResponse.fromRawJson(response.body);
      final data = resp.options.bodytypes;
      return data;
    } else {
      throw ApiErrors();
    }
  }
}
