// To parse this JSON data, do
//
//     final addItem = addItemFromJson(jsonString);

import 'dart:convert';

AddItem addItemFromJson(String str) => AddItem.fromJson(json.decode(str));

String addItemToJson(AddItem data) => json.encode(data.toJson());

class AddItem {
  AddItem({
    this.photos,
    this.userLike,
    this.id,
    this.itemName,
    this.location,
    this.description,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<dynamic>? photos;
  List<dynamic>? userLike;
  String? id;
  String? itemName;
  String? location;
  String? description;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory AddItem.fromJson(Map<String, dynamic> json) => AddItem(
        photos: json["photos"] == null
            ? null
            : List<dynamic>.from(json["photos"].map((x) => x)),
        userLike: json["userLike"] == null
            ? null
            : List<dynamic>.from(json["userLike"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        itemName: json["itemName"] == null ? null : json["itemName"],
        location: json["location"] == null ? null : json["location"],
        description: json["description"] == null ? null : json["description"],
        user: json["user"] == null ? null : json["user"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "photos":
            photos == null ? null : List<dynamic>.from(photos!.map((x) => x)),
        "userLike": userLike == null
            ? null
            : List<dynamic>.from(userLike!.map((x) => x)),
        "_id": id == null ? null : id,
        "itemName": itemName == null ? null : itemName,
        "location": location == null ? null : location,
        "description": description == null ? null : description,
        "user": user == null ? null : user,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
