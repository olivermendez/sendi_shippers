import 'dart:convert';

class PaymentResponse {
  PaymentResponse({
    required this.success,
    required this.yourPaymentsMethods,
  });

  bool success;
  List<YourPaymentsMethod> yourPaymentsMethods;

  factory PaymentResponse.fromRawJson(String str) =>
      PaymentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        success: json["success"],
        yourPaymentsMethods: List<YourPaymentsMethod>.from(
            json["yourPaymentsMethods"]
                .map((x) => YourPaymentsMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "yourPaymentsMethods":
            List<dynamic>.from(yourPaymentsMethods.map((x) => x.toJson())),
      };
}

class YourPaymentsMethod {
  YourPaymentsMethod({
    required this.id,
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
    required this.cardHolder,
    required this.amount,
    required this.user,
    required this.createdAt,
    required this.v,
  });

  String id;
  int cardNumber;
  String expirationDate;
  String cvv;
  String cardHolder;
  int amount;
  String user;
  DateTime createdAt;
  int v;

  factory YourPaymentsMethod.fromRawJson(String str) =>
      YourPaymentsMethod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory YourPaymentsMethod.fromJson(Map<String, dynamic> json) =>
      YourPaymentsMethod(
        id: json["_id"],
        cardNumber: json["cardNumber"],
        expirationDate: json["expirationDate"],
        cvv: json["cvv"],
        cardHolder: json["cardHolder"],
        amount: json["amount"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cardNumber": cardNumber,
        "expirationDate": expirationDate,
        "cvv": cvv,
        "cardHolder": cardHolder,
        "amount": amount,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
