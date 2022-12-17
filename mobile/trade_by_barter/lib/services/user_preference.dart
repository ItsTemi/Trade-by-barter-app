import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/screens/sign_in/login_page.dart';
import 'dart:async';

import '../models/login_response.dart';
import '../models/user_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");
    return isKeyExist;
  }

  static Future<LoginResponse?> loginDetails() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      return loginResponseFromJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(LoginResponse model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "login_details", syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.of(context).pushNamedAndRemoveUntil(
        LoginPage.routeName, (Route<dynamic> route) => false);
  }
}

class UserPreferences {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId!);
    prefs.setString("msg", user.msg!);
    prefs.setString("email", user.email!);
    prefs.setString("phonenumber", user.phonenumber!);
    prefs.setString("username", user.username!);
    prefs.setString("verificationToken", user.verificationToken!);

    return prefs.commit();
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString("userId");
    String? username = prefs.getString("username");
    String? email = prefs.getString("email");
    String? phonenumber = prefs.getString("phonenumber");
    String? msg = prefs.getString("msg");
    String? verificationToken = prefs.getString("verificationToken");

    return UserModel(
        userId: userId,
        username: username,
        email: email,
        phonenumber: phonenumber,
        msg: msg,
        verificationToken: verificationToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("username");
    prefs.remove("email");
    prefs.remove("phonenumber");
    prefs.remove("msg");
    prefs.remove("verificationToken");
  }

  Future<String?> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? verificationToken = prefs.getString("verificationToken");
    return verificationToken;
  }
}
