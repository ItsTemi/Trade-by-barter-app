import 'dart:convert';

import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier{
  List<Items>? items;
  int? itemCount;

  ProductModel({this.items, this.itemCount});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['itemCount'] = this.itemCount;
    return data;
  }
}

class Items {
  List<String>? photos;
  bool? isFavorite;
  String? sId;
  String? itemName;
  String? location;
  String? description;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Items(
      {this.photos,
      this.isFavorite,
      this.sId,
      this.itemName,
      this.location,
      this.description,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Items.fromJson(Map<String, dynamic> json) {
    photos = json['photos'].cast<String>();
    isFavorite = json['isFavorite'];
    sId = json['_id'];

    itemName = json['itemName'];
    location = json['location'];
    description = json['description'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photos'] = this.photos;
    data['isFavorite'] = this.isFavorite;
    data['_id'] = this.sId;

    data['itemName'] = this.itemName;
    data['location'] = this.location;
    data['description'] = this.description;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
