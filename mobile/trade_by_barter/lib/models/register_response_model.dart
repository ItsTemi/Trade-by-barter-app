// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.msg,
    this.user,
    this.email,
    this.userId,
  });

  String? msg;
  String? user;
  String? email;
  String? userId;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        msg: json["msg"] == null ? null : json["msg"],
        user: json["user"] == null ? null : json["user"],
        email: json["email"] == null ? null : json["email"],
        userId: json["userId"] == null ? null : json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "user": user == null ? null : user,
        "email": email == null ? null : email,
        "userId": userId == null ? null : userId,
      };
}
