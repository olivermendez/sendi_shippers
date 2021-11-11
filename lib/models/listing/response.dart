import 'dart:convert';

import 'listing.dart';

class ListingResponse {
  ListingResponse({
    required this.success,
    required this.listing,
  });

  bool success;
  Listing listing;

  factory ListingResponse.fromRawJson(String str) =>
      ListingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListingResponse.fromJson(Map<String, dynamic> json) =>
      ListingResponse(
        success: json["success"],
        listing: Listing.fromJson(json["listing"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "listing": listing.toJson(),
      };
}
