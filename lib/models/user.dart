class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.password,
    required this.cedula,
    required this.phone,
    required this.createdAt,
    required this.v,
  });

  String id;
  String name;
  String username;
  String email;
  String role;
  String password;
  String cedula;
  String phone;
  DateTime createdAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
        password: json["password"],
        cedula: json["cedula"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["createdAt"]),
        // ignore: prefer_if_null_operators
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "email": email,
        "role": role,
        "password": password,
        "cedula": cedula,
        "phone": phone,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
