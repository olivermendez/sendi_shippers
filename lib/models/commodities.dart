import 'dart:convert';

class Options {
  Options({
    required this.commodities,
  });

  List<Commodity> commodities;

  factory Options.fromRawJson(String str) => Options.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        commodities: List<Commodity>.from(
            json["commodities"].map((x) => Commodity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "commodities": List<dynamic>.from(commodities.map((x) => x.toJson())),
      };
}

class Commodity {
  Commodity({
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

  factory Commodity.fromRawJson(String str) =>
      Commodity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Commodity.fromJson(Map<String, dynamic> json) => Commodity(
        value: json["value"],
        label: json["label"],
        shortLabel: json["shortLabel"],
        route: json["route"],
        subCommodities: List<SubCommodity>.from(
            json["subCommodities"].map((x) => SubCommodity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
        "shortLabel": shortLabel,
        "route": route,
        "subCommodities":
            List<dynamic>.from(subCommodities.map((x) => x.toJson())),
      };
}

class SubCommodity {
  SubCommodity({
    required this.value,
    required this.label,
  });

  String value;
  String label;

  factory SubCommodity.fromRawJson(String str) =>
      SubCommodity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCommodity.fromJson(Map<String, dynamic> json) => SubCommodity(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
