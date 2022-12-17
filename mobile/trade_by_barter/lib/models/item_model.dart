class SingleItemModel {
  SingleItemModel({
    required this.item,
  });
  late final List<Item> item;

  SingleItemModel.fromJson(Map<String, dynamic> json) {
    item = List.from(json['item']).map((e) => Item.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['item'] = item.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Item {
  Item({
    required this.photos,
    required this.isFavorite,
    required this.id,
    required this.userLike,
    required this.itemName,
    required this.location,
    required this.description,
    this.user,
    required this.createdAt,
    required this.updatedAt,
  });
  late final List<String> photos;
  late final bool isFavorite;
  late final String id;
  late final List<dynamic> userLike;
  late final String itemName;
  late final String location;
  late final String description;
  late final Null user;
  late final String createdAt;
  late final String updatedAt;

  Item.fromJson(Map<String, dynamic> json) {
    photos = List.castFrom<dynamic, String>(json['photos']);
    isFavorite = json['isFavorite'];
    id = json['id'];
    userLike = List.castFrom<dynamic, dynamic>(json['userLike']);
    itemName = json['itemName'];
    location = json['location'];
    description = json['description'];
    user = null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photos'] = photos;
    _data['isFavorite'] = isFavorite;
    _data['id'] = id;
    _data['userLike'] = userLike;
    _data['itemName'] = itemName;
    _data['location'] = location;
    _data['description'] = description;
    _data['user'] = user;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;

    return _data;
  }
}
