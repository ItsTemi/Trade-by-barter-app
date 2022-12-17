import 'package:flutter/widgets.dart';
import 'package:shop/screens/sign_in/sign_in_screen.dart';
import 'package:shop/screens/sign_up/sign_up_screen.dart';
import 'package:shop/splash/splash_screen.dart';

import '../screens/complete_profile/complete_profile_screen.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../screens/home1/initial_home.dart';
import '../screens/home2/home_screen.dart';
import '../screens/like_screen/like_screen.dart';
import '../screens/login_success/login_success_screen.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/sign_in/login_page.dart';
import '../screens/sign_up/register_page.dart';
import '../screens/upload_screen/upload_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  RegisterPage.routeName: (context) => RegisterPage(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  InitialHome.routeName: (context) => InitialHome(),
  HomeScreen.routeName: (context) => HomeScreen(),
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  UploadScreen.routeName: (context) => UploadScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),

  LikeScreen.routeName: (context) => LikeScreen(),
};
