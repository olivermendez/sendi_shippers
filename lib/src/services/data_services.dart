//import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/bodytypes.dart';
import '../../models/listing/dynamiclisting.dart';
import '../../models/listing/listing.dart';
import '../../models/locations/locations_models.dart';
import '../../models/motorbodytypes.dart';
import '../../models/response_options.dart';
import '../../models/token.dart';

class Constants {
  static String get apiUrl => 'http://localhost:8000/api/v1/';
}

class DataServices {
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

  Future<BodyTypeResponse?> getVehicleBodytype() async {
    var url = Uri.parse('${Constants.apiUrl}vehicle/bodytypes');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    final data = BodyTypeResponse.fromRawJson(response.body);
    return data;
  }

  Future<DynamicListingResponse?> getActiveListingByUser(Token token) async {
    var url =
        Uri.parse('${Constants.apiUrl}listings/user/${token.user.id}/active');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    final listingByUser = DynamicListingResponse.fromRawJson(response.body);
    return listingByUser;
  }

  Future<MotorBodyTypesResponse?> getMotorBodytypes() async {
    var url = Uri.parse('${Constants.apiUrl}motor/bodytypes');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    final optionsResponse = MotorBodyTypesResponse.fromRawJson(response.body);
    return optionsResponse;
  }

  Future<DynamicListingResponse?> getDeliveredListingByUserId(
      Token token) async {
    var url = Uri.parse(
        '${Constants.apiUrl}listings/user/${token.user.id}/delivered');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    final listingByUser = DynamicListingResponse.fromRawJson(response.body);
    return listingByUser;
  }

  Future<DynamicListingResponse?> getBookedListingByUser(Token token) async {
    var url =
        Uri.parse('${Constants.apiUrl}listings/user/${token.user.id}/booked');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    final listingByUser = DynamicListingResponse.fromRawJson(response.body);
    return listingByUser;
  }

  Future<LocationResponse> getSingleLocation(String id) async {
    var url = Uri.parse('${Constants.apiUrl}listings/$id/location');

    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    var body = response.body;
    final locationResponse = LocationResponse.fromRawJson(body);

    return locationResponse;
  }
}
