import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/models/product_model.dart';
import '../../../services/controller.dart';
import '../../../widgets/appbar_icons.dart';
import '../../../widgets/size_config.dart';
import 'banner.dart';
import 'home_header.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = true;
  List<Items> listHomeItems = [];

  getHomeItems() async {
    listHomeItems = await ProductController().getAllItems();
    print("count home: ${listHomeItems.length}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeItems();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            BannerContainer(),
            SizedBox(height: getProportionateScreenWidth(30)),
            SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Text(
                      'Latest Products',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    FutureBuilder(
                      future: ProductController().getAllItems(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("An error occured ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData == null) {
                          return Center(
                            child: Text("No product has been added"),
                          );
                        }

                        // List<Item> items = snapshot.data;

                        return ListView.builder(
                          itemCount: listHomeItems.length,
                          itemBuilder: (context, index) {
                            return ItemCard(
                              title: listHomeItems[index].itemName.toString(),
                              photos: listHomeItems[index].photos.toString(),
                              location:
                                  listHomeItems[index].location.toString(),
                              description:
                                  listHomeItems[index].description.toString(),
                            );
                          },
                        );
                      },
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
