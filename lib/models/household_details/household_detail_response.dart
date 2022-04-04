// To parse this JSON data, do
//
//     final getHouseholdDetailsResponse = getHouseholdDetailsResponseFromJson(jsonString);

import 'dart:convert';

class GetHouseholdDetailsResponse {
  GetHouseholdDetailsResponse({
    required this.success,
    required this.furniture,
  });

  bool success;
  List<GetFurnitureDetails> furniture;

  factory GetHouseholdDetailsResponse.fromRawJson(String str) =>
      GetHouseholdDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetHouseholdDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetHouseholdDetailsResponse(
        success: json["success"],
        furniture: List<GetFurnitureDetails>.from(
            json["furniture"].map((x) => GetFurnitureDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "furniture": List<dynamic>.from(furniture.map((x) => x.toJson())),
      };
}

class GetFurnitureDetails {
  GetFurnitureDetails({
    required this.id,
    required this.width,
    required this.height,
    required this.weight,
    required this.listing,
    required this.v,
  });

  String id;
  int width;
  int height;
  int weight;
  String listing;
  int v;

  factory GetFurnitureDetails.fromRawJson(String str) =>
      GetFurnitureDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetFurnitureDetails.fromJson(Map<String, dynamic> json) =>
      GetFurnitureDetails(
        id: json["_id"],
        width: json["width"],
        height: json["height"],
        weight: json["weight"],
        listing: json["listing"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "width": width,
        "height": height,
        "weight": weight,
        "listing": listing,
        "__v": v,
      };
}
