import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/widgets/size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../components/default_button.dart';
import '../../widgets/constants.dart';
import '../login_success/login_success_screen.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = "/otp";

  // OtpScreen({required this.userId});
  //
  // String userId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  UserModel? usermodel;
  TextEditingController otpverifycontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("OTP Verification"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Text(
                    "OTP Verification",
                    style: headingStyle,
                  ),
                  Text("We sent your code to your email"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("This code will expired in "),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 30.0, end: 0.0),
                        duration: Duration(seconds: 30),
                        builder: (_, dynamic value, child) => Text(
                          "00:${value.toInt()}",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.15),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    controller: otpverifycontroller,
                    decoration: InputDecoration(labelText: 'Enter OTP code'),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.15),
                  DefaultButton(
                    text: "Verify OTP",
                    press: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? userId = prefs.getString("userId");
                      String enteredOtpCode = otpverifycontroller.text;

                      var url =
                          "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/verify-email/{id}";
                      //API for OTP code
                      var response = await http.post(Uri.parse(url));
                      var body = json.decode(response.body);
                      // Retrieve the ID from the response
                      String id = body['userId'];
                      var verificationResponse = await http.post(Uri.parse(
                          'https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/verify-email?userId=$id&code=$enteredOtpCode'));

                      if (verificationResponse.statusCode == 200) {
                        print('response status: ${response.statusCode} ');
                        // Show success message
                        Flushbar(
                          title: "Successful",
                          message: "OTP verified successfully",
                          duration: const Duration(seconds: 10),
                        ).show(context);
                      } else {
                        // Show error message
                        Flushbar(
                          title: "Failed",
                          message: "Failed to verify OTP",
                          duration: const Duration(seconds: 10),
                        ).show(context);
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) =>
                                  LoginSuccessScreen()));
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  GestureDetector(
                    onTap: () {
                      // OTP code resend
                    },
                    child: Text(
                      "Resend OTP Code",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
