import 'dart:convert';

class VehicleBodyTypeResponse {
  VehicleBodyTypeResponse({
    required this.succes,
    required this.options,
  });

  bool succes;
  Options options;

  factory VehicleBodyTypeResponse.fromRawJson(String str) =>
      VehicleBodyTypeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleBodyTypeResponse.fromJson(Map<String, dynamic> json) =>
      VehicleBodyTypeResponse(
        succes: json["succes"],
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "options": options.toJson(),
      };
}

class Options {
  Options({
    required this.bodytypes,
  });

  List<VehicleBodytypeDetail> bodytypes;

  factory Options.fromRawJson(String str) => Options.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        bodytypes: List<VehicleBodytypeDetail>.from(
            json["bodytypes"].map((x) => VehicleBodytypeDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bodytypes": List<dynamic>.from(bodytypes.map((x) => x.toJson())),
      };
}

class VehicleBodytypeDetail {
  VehicleBodytypeDetail({
    required this.value,
    required this.image,
    required this.details,
  });

  String value;
  String image;
  List<Detail> details;

  factory VehicleBodytypeDetail.fromRawJson(String str) =>
      VehicleBodytypeDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleBodytypeDetail.fromJson(Map<String, dynamic> json) =>
      VehicleBodytypeDetail(
        value: json["value"],
        image: json["image"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "image": image,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    required this.dimensions,
    required this.weight,
  });

  String dimensions;
  String weight;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        dimensions: json["dimensions"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions,
        "weight": weight,
      };
}
