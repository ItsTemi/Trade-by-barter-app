import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../components/default_button.dart';
import '../../theme/theme_data.dart';
import '../../widgets/enums.dart';
import '../../widgets/size_config.dart';
import '../home2/home_screen.dart';

class UploadScreen extends StatefulWidget {
  static String routeName = "/upload";
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill the Required Details', style: Styles.headLineStyle),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.upload),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Text(
                'Upload different images of your item',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(),
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 3.0,
                        ),
                      ],
                      color: Colors.white),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(children: [
                                Container(
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200),
                                  child: Image(
                                      image:
                                          AssetImage('assets/images/box.png')),
                                ),
                                Positioned(
                                    right: -15,
                                    top: -15,
                                    child: IconButton(
                                      onPressed: () {
                                        // delete items
                                      },
                                      icon: Icon(Icons.close),
                                    ))
                              ]),
                              SizedBox(width: 4),
                              Stack(children: [
                                Container(
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200),
                                  child: Image(
                                      image:
                                          AssetImage('assets/images/box.png')),
                                ),
                                Positioned(
                                    right: -15,
                                    top: -15,
                                    child: IconButton(
                                      onPressed: () {
                                        // delete items
                                      },
                                      icon: Icon(Icons.close),
                                    ))
                              ]),
                              SizedBox(width: 4),
                              Stack(children: [
                                Container(
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200),
                                  child: Image(
                                      image:
                                          AssetImage('assets/images/box.png')),
                                ),
                                Positioned(
                                    right: -15,
                                    top: -15,
                                    child: IconButton(
                                      onPressed: () {
                                        // delete items
                                      },
                                      icon: Icon(Icons.close),
                                    ))
                              ]),
                              SizedBox(width: 4),
                              Stack(children: [
                                Container(
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey.shade200),
                                  child: Image(
                                      image:
                                          AssetImage('assets/images/box.png')),
                                ),
                                Positioned(
                                    right: -15,
                                    top: -15,
                                    child: IconButton(
                                      onPressed: () {
                                        // delete items
                                      },
                                      icon: Icon(Icons.close),
                                    ))
                              ]),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                'Discription of your item',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                child: Container(
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'condition of your item',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(1))),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              Center(
                child: DefaultButton(
                  text: "Upload",
                  press: () {
                    {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
