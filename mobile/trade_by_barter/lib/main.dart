import 'package:flutter/material.dart';
import 'package:shop/widgets/enums.dart';
import 'package:shop/widgets/routes.dart';

import 'package:shop/splash/splash_screen.dart';
import 'package:shop/widgets/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeBarter App',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
