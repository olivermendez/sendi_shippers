// To parse this JSON data, do
//
//     final getVehicleDetailsResponse = getVehicleDetailsResponseFromJson(jsonString);

import 'dart:convert';

class GetVehicleDetailsResponse {
  GetVehicleDetailsResponse({
    required this.success,
    required this.details,
  });

  bool success;
  List<VehicleDetails> details;

  factory GetVehicleDetailsResponse.fromRawJson(String str) =>
      GetVehicleDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetVehicleDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetVehicleDetailsResponse(
        success: json["success"],
        details: List<VehicleDetails>.from(
            json["details"].map((x) => VehicleDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class VehicleDetails {
  VehicleDetails({
    required this.id,
    required this.bodytype,
    required this.dimensions,
    required this.weight,
    required this.operable,
    required this.convertible,
    required this.modified,
    required this.listing,
    required this.createdAt,
    required this.v,
  });

  String id;
  String bodytype;
  String dimensions;
  String weight;
  bool operable;
  bool convertible;
  bool modified;
  String listing;
  DateTime createdAt;
  int v;

  factory VehicleDetails.fromRawJson(String str) =>
      VehicleDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
        id: json["_id"],
        bodytype: json["bodytype"],
        dimensions: json["dimensions"],
        weight: json["weight"],
        operable: json["operable"],
        convertible: json["convertible"],
        modified: json["modified"],
        listing: json["listing"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "bodytype": bodytype,
        "dimensions": dimensions,
        "weight": weight,
        "operable": operable,
        "convertible": convertible,
        "modified": modified,
        "listing": listing,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
