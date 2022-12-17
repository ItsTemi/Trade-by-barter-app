import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? msg;
  String? username;
  String? email;
  String? userId;
  String? phonenumber;
  String? verificationToken;

  UserModel(
      {this.msg,
      this.verificationToken,
      this.username,
      this.email,
      this.phonenumber,
      this.userId});

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   msg = json['msg'];
  //   user = json['user'];
  //   email = json['email'];
  //   userId = json['userId'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['username'] = this.username;
    data['email'] = this.email;
    data['userId'] = this.userId;
    data['phonenumber'] = this.phonenumber;
    data['verificationToken'] = this.verificationToken;
    return data;
  }

  factory UserModel.fromJson(Map<String, dynamic> responseData) {
    return UserModel(
      userId: responseData['id'],
      verificationToken: responseData['verificationToken'],
      email: responseData['email'],
      phonenumber: responseData['phonenumber'],
      msg: responseData['msg'],
      username: responseData['username'],
    );
  }
  static List<UserModel> usersFromJson(List userJson) {
    // print("data ${productJson[0]}");
    return userJson.map((data) {
      return UserModel.fromJson(data);
    }).toList();
  }
}
