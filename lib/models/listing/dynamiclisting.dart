import 'dart:convert';

import 'listing.dart';

class DynamicListingResponse {
  DynamicListingResponse({
    required this.success,
    required this.listing,
  });

  bool success;
  List<Listing> listing;

  factory DynamicListingResponse.fromRawJson(String str) =>
      DynamicListingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DynamicListingResponse.fromJson(Map<String, dynamic> json) =>
      DynamicListingResponse(
        success: json["success"],
        listing:
            List<Listing>.from(json["listing"].map((x) => Listing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "listing": List<dynamic>.from(listing.map((x) => x.toJson())),
      };
}
