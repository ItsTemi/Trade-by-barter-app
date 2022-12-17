import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../widgets/enums.dart';

class LikeScreen extends StatefulWidget {
  static String routeName = "/like";

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            CustomBottomNavBar(selectedMenu: MenuState.favourite));
  }
}
