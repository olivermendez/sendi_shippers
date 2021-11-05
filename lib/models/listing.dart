import 'dart:convert';

class CreateListingResponse {
  CreateListingResponse({
    required this.success,
    required this.listing,
  });

  bool success;
  Listing listing;

  factory CreateListingResponse.fromRawJson(String str) =>
      CreateListingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateListingResponse.fromJson(Map<String, dynamic> json) =>
      CreateListingResponse(
        success: json["success"],
        listing: Listing.fromJson(json["listing"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "listing": listing.toJson(),
      };
}

class Listing {
  Listing({
    required this.title,
    required this.description,
    required this.photo,
    required this.comodity,
    required this.user,
    required this.id,
    required this.createdAt,
    required this.v,
    required this.listingId,
  });

  String title;
  String description;
  String photo;
  String comodity;
  String user;
  String id;
  DateTime createdAt;
  int v;
  String listingId;

  factory Listing.fromRawJson(String str) => Listing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        title: json["title"],
        description: json["description"],
        photo: json["photo"],
        comodity: json["comodity"],
        user: json["user"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        listingId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "photo": photo,
        "comodity": comodity,
        "user": user,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "id": listingId,
      };
}
