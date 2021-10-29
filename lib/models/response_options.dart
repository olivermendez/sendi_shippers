import 'dart:convert';

import 'commodities.dart';

class OptionsResponse {
  OptionsResponse({
    required this.succes,
    required this.options,
  });

  bool succes;
  Options options;

  factory OptionsResponse.fromRawJson(String str) =>
      OptionsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OptionsResponse.fromJson(Map<String, dynamic> json) =>
      OptionsResponse(
        succes: json["succes"],
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "options": options.toJson(),
      };
}
