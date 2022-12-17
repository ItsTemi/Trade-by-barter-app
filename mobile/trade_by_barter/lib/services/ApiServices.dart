import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices {
  String? url;

  ApiServices({this.url});

  //Fetching single item
  Future<Map> getItem(itemid) async {
    Map item = {};
    //Get the item from API
    http.Response response = await http.get(Uri.parse(
        'https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/getUserItems'));
    if (response.statusCode == 200) {
      var data = response.body;
      item = jsonDecode(data);
    }

    return item;
  }

  //Add a new item

  Future<bool> addItem(Map data) async {
    bool status = false;
    //Add the item from API
    http.Response response = await http.post(
        Uri.parse(
            'https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/createitem'),
        body: jsonEncode(data),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  //Update an item
  Future<bool> updateItem(Map data, String itemid) async {
    bool status = false;
    //update the item from API
    http.Response response = await http.patch(
        Uri.parse(
            'https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/updateItem/$itemid'),
        body: jsonEncode(data),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  //Fetch All Items
  Future<List<Map>> fetchAllItems() async {
    List<Map> items = [];
    http.Response response = await http.get(Uri.parse(
        'https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/getAllItems'));
    if (response.statusCode == 200) {
      var data = response.body;
      items = jsonDecode(data);
    }
    return items;
  }

  //Delete an item
  Future<bool> deleteItem(String itemid) async {
    bool status = false;
    //delete item from database
    http.Response response = await http.delete(Uri.parse(
        'https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/deleteItem/$itemid'));
    if (response.statusCode == 200) {
      status = true;
    }

    return status;
  }

  Future getApi() async {
    var uri = Uri.parse(url!);
    Map<String, String>? headers = {};
    Response response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      var body = jsonDecode(response.body);
      return body;
    } else {
      print(response.statusCode);
    }
  }

  Future postApi() async {
    var uri = Uri.parse(url!);
    var body = {};
    Map<String, String>? headers = {};
    Response response = await post(uri, body: body, headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      var body = jsonDecode(response.body);
      return body;
    } else {
      print(response.statusCode);
    }
  }

  // static Future<List<ProductModel>> getAllProducts(String limit) async {
  //   List temp = await getData(target: "/item/getAllItems", limit: limit);
  //   return ProductModel.productsFromJson(temp);
  // }

  // static Future<List<UserModel>> getAllUsers() async {
  //   List temp = await postData(target: "user");
  //   return UserModel.usersFromJson(temp);
  // }
  //
  // static Future<ProductModel> getItemDetailById(String sId) async {
  //   try {
  //     var uri = Uri.https(BASE_URL, "/item/getSingleItem");
  //     var response = await http.get(uri);
  //
  //     // print("response ${jsonDecode(response.body)}");
  //
  //     var data = jsonDecode(response.body);
  //     if (response.statusCode != 200) {
  //       throw data[" message"];
  //     }
  //     return ProductModel.fromJson(data);
  //   } catch (error) {
  //     print("An error occured fetching product info $error");
  //     throw error.toString();
  //   }
  // }

}
