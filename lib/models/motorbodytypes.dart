import 'dart:convert';

class MotorBodyTypesResponse {
  MotorBodyTypesResponse({
    required this.succes,
    required this.options,
  });

  bool succes;
  Options options;

  factory MotorBodyTypesResponse.fromRawJson(String str) =>
      MotorBodyTypesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MotorBodyTypesResponse.fromJson(Map<String, dynamic> json) =>
      MotorBodyTypesResponse(
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
    required this.bodytypesmotor,
  });

  List<Bodytypesmotor> bodytypesmotor;

  factory Options.fromRawJson(String str) => Options.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        bodytypesmotor: List<Bodytypesmotor>.from(
            json["bodytypesmotor"].map((x) => Bodytypesmotor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bodytypesmotor":
            List<dynamic>.from(bodytypesmotor.map((x) => x.toJson())),
      };
}

class Bodytypesmotor {
  Bodytypesmotor({
    required this.value,
    required this.image,
    required this.details,
  });

  String value;
  String image;
  Details details;

  factory Bodytypesmotor.fromRawJson(String str) =>
      Bodytypesmotor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bodytypesmotor.fromJson(Map<String, dynamic> json) => Bodytypesmotor(
        value: json["value"],
        image: json["image"],
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "image": image,
        "details": details.toJson(),
      };
}

class Details {
  Details({
    required this.dimensions,
    required this.weight,
  });

  String dimensions;
  String weight;

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        dimensions: json["dimensions"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions,
        "weight": weight,
      };
}
