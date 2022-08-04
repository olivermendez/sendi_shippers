// To parse this JSON data, do
//
//     final commoditiesResponse = commoditiesResponseFromJson(jsonString);

import 'dart:convert';

CommoditiesResponse commoditiesResponseFromJson(String str) =>
    CommoditiesResponse.fromJson(json.decode(str));

//String commoditiesResponseToJson(CommoditiesResponse data) =>
// json.encode(data.toJson());

class CommoditiesResponse {
  CommoditiesResponse({
    required this.succes,
    required this.options,
  });

  bool succes;
  CommoditiesOptions options;

  factory CommoditiesResponse.fromJson(Map<String, dynamic> json) =>
      CommoditiesResponse(
        succes: json["succes"],
        options: CommoditiesOptions.fromJson(json["options"]),
      );
}

class CommoditiesOptions {
  CommoditiesOptions({
    required this.commodities,
  });

  List<CommodityDetails> commodities;

  factory CommoditiesOptions.fromJson(Map<String, dynamic> json) =>
      CommoditiesOptions(
        commodities: List<CommodityDetails>.from(
            json["commodities"].map((x) => CommodityDetails.fromJson(x))),
      );
}

class CommodityDetails {
  CommodityDetails({
    required this.value,
    required this.label,
    required this.shortLabel,
    required this.route,
    required this.subCommodities,
  });

  String value;
  String label;
  String shortLabel;
  String route;
  List<SubCommodity> subCommodities;

  factory CommodityDetails.fromJson(Map<String, dynamic> json) =>
      CommodityDetails(
        value: json["value"],
        label: json["label"],
        shortLabel: json["shortLabel"],
        route: json["route"],
        subCommodities: List<SubCommodity>.from(
            json["subCommodities"].map((x) => SubCommodity.fromJson(x))),
      );
}

class SubCommodity {
  SubCommodity({
    required this.value,
    required this.label,
    required this.image,
  });

  String value;
  String label;
  String? image;

  factory SubCommodity.fromRawJson(String str) =>
      SubCommodity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCommodity.fromJson(Map<String, dynamic> json) => SubCommodity(
      value: json["value"], label: json["label"], image: json['image']);

  Map<String, dynamic> toJson() =>
      {"value": value, "label": label, "image": image};
}
