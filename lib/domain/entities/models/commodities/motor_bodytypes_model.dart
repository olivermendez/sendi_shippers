import 'dart:convert';

class MotorBodyTypeResponse {
  MotorBodyTypeResponse({
    required this.succes,
    required this.options,
  });

  bool succes;
  Options options;

  factory MotorBodyTypeResponse.fromRawJson(String str) =>
      MotorBodyTypeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MotorBodyTypeResponse.fromJson(Map<String, dynamic> json) =>
      MotorBodyTypeResponse(
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

  List<MotorBodytypeDetail> bodytypes;

  factory Options.fromRawJson(String str) => Options.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        bodytypes: List<MotorBodytypeDetail>.from(
            json["bodytypes"].map((x) => MotorBodytypeDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bodytypes": List<dynamic>.from(bodytypes.map((x) => x.toJson())),
      };
}

class MotorBodytypeDetail {
  MotorBodytypeDetail({
    required this.value,
    required this.image,
    required this.details,
  });

  String value;
  String image;
  List<Detail> details;

  factory MotorBodytypeDetail.fromRawJson(String str) =>
      MotorBodytypeDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MotorBodytypeDetail.fromJson(Map<String, dynamic> json) =>
      MotorBodytypeDetail(
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
