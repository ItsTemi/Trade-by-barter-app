import '../models/product_model.dart';
import 'ApiServices.dart';

class ProductController {
  getAllItems() async {
    var response = await ApiServices(
            url:
                "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/getAllItems")
        .getApi();

    List<Items> listProduct = [];
    if (response["status"] == true && response["code"] == '200') {
      for (int i = 0; i < response["data"].length; i++) {
        Items product = Items.fromJson(response["data"][i]);
        listProduct.add(product);
      }
    }
    // print("count: ${listItem.length}");
    print("response: $response");
    return listProduct;
  }

  getSingleItemById(String id, {required sId}) async {
    var response = await ApiServices(
            url:
                "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/getSingleItem/$id")
        .getApi();

    print("response: $response");
    List<Items> listItem = [];
    if (response["status"] == true && response["code"] == '200') {
      for (int i = 0; i < response["data"].length; i++) {
        Items _item = Items.fromJson(response["data"][i]);
        listItem.add(_item);
      }
    }
    // print("count: ${listItem.length}");
    return listItem;
  }
}
