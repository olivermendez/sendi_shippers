import 'package:my_app/models/user.dart';

class Token {
  Token({
    required this.token,
    required this.user,
  });

  String token = '';
  User user = User(
      id: '',
      name: '',
      username: '',
      email: '',
      role: '',
      cedula: '',
      phone: '',
      password: '',
      createdAt: DateTime.now(),
      v: 0);

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}
