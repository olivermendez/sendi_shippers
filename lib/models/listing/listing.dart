import 'dart:convert';

class Listing {
  Listing({
    required this.id,
    required this.status,
    required this.title,
    required this.description,
    required this.quantity,
    required this.photo,
    required this.comodity,
    required this.subcomodity,
    required this.user,
    required this.createdAt,
    required this.v,
    required this.listingId,
  });

  String id;
  String status;
  String title;
  String description;
  String quantity;
  String photo;
  String comodity;
  String subcomodity;
  String user;
  DateTime createdAt;
  int v;
  String listingId;

  factory Listing.fromRawJson(String str) => Listing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        id: json["_id"],
        status: json["status"],
        title: json["title"],
        description: json["description"],
        quantity: json["quantity"],
        photo: json["photo"],
        comodity: json["comodity"],
        subcomodity: json["subcomodity"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        listingId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "title": title,
        "description": description,
        "quantity": quantity,
        "photo": photo,
        "comodity": comodity,
        "subcomodity": subcomodity,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "id": listingId,
      };
}
