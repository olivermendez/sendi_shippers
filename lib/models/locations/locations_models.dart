// To parse this JSON data, do
//
//     final locationResponse = locationResponseFromJson(jsonString);

import 'dart:convert';

class LocationResponse {
  LocationResponse({
    required this.success,
    required this.data,
  });

  bool success;
  List<Location> data;

  factory LocationResponse.fromRawJson(String str) =>
      LocationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        success: json["success"],
        data:
            List<Location>.from(json["data"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    required this.price,
    required this.category,
    required this.addressFrom,
    required this.addressTo,
  });

  int price;
  String category;
  String addressFrom;
  String addressTo;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        price: json["price"],
        category: json["category"],
        addressFrom: json["addressFrom"],
        addressTo: json["addressTo"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "category": category,
        "addressFrom": addressFrom,
        "addressTo": addressTo,
      };
}
