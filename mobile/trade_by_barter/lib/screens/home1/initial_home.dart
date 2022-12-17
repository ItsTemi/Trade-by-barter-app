import 'package:flutter/material.dart';
import 'package:shop/screens/home2/components/item_card.dart';
import 'package:shop/services/ApiServices.dart';

import '../../models/product_model.dart';
import '../../services/controller.dart';
import '../../theme/theme_data.dart';

class InitialHome extends StatefulWidget {
  static String routeName = "/home1";
  const InitialHome({Key? key}) : super(key: key);

  @override
  State<InitialHome> createState() => _InitialHomeState();
}

class _InitialHomeState extends State<InitialHome> {
  // Future<List<Map>> productModel = ApiServices().fetchAllItems();
  List<Items> listHomeProducts = [];

  getHomeItems() async {
    listHomeProducts = await ProductController().getAllItems();
    print("count home: ${listHomeProducts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.purpleAccent],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text('WeBarter', style: Styles.headLineStyle),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getHomeItems(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occured ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            listHomeProducts = snapshot.data;

            return ListView.builder(
                itemCount: listHomeProducts.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                      title: listHomeProducts[index].itemName.toString(),
                      location: listHomeProducts[index].location.toString(),
                      description:
                          listHomeProducts[index].description.toString(),
                      photos: listHomeProducts[index].photos.toString());
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
