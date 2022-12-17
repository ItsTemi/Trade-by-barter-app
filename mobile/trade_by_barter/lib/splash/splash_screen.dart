import 'package:flutter/material.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/widgets/size_config.dart';
import 'package:shop/splash/components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
