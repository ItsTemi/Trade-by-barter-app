import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/coustom_bottom_nav_bar.dart';

import '../../models/user_model.dart';
import '../../services/user_provider.dart';
import '../../widgets/enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.account),
    );
  }
}
