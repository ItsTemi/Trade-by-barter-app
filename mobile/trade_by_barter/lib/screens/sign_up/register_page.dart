import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/loginModel.dart';
import 'package:shop/screens/otp/otp_screen.dart';
import 'package:shop/services/ApiServices.dart';
import 'package:shop/widgets/constants.dart';
import 'package:http/http.dart' as http;
import '../../components/custom_prefix_icon.dart';
import '../../components/default_button.dart';
import '../../components/no_account_text.dart';
import '../../components/socal_card.dart';
import '../../models/user_model.dart';
import '../../widgets/size_config.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = "/sign_up";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool? remember = false;
  final formKey = new GlobalKey<FormState>();
  bool vis = true;
  String? apiToken;
  String registerUrl =
      "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/register";
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController phonenumbercontroller = new TextEditingController();
  bool isLoading = false;

  handleLoginError(int statusCode) {
    // Check the status code of the response to determine the cause of the error
    if (statusCode == 401) {
      // If the status code is 401 (Unauthorized), the user's login credentials were invalid
      print('Invalid login credentials. Please try again.');
    } else if (statusCode == 500) {
      // If the status code is 500 (Internal Server Error), there was a problem with the server
      print('There was a problem with the server. Please try again later.');
    } else {
      // For any other status code, print a generic error message
      print('An error occurred. Please try again later.');
    }
  }

  doRegister(String username, String phonenumber, String email,
      String password) async {
    setState(() {
      isLoading = true;
    });

    // Replace with the user's sign up information
    var body = json.encode({
      'password': password,
      'username': username,
      'phonenumber': phonenumber,
      'email': email
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

// Make a POST request to the sign up endpoint
    await http
        .post(Uri.parse(registerUrl), body: body, headers: headers)
        .then((response) {
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        body = jsonDecode(response.body);
        print('response status: ${response.statusCode} ');
        print('response status: ${response.body} ');
        if (body != null) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => OtpScreen()));
        } else {
          Flushbar(
            title: "Invalid form",
            message: "Please Complete the form properly",
            duration: const Duration(seconds: 10),
          ).show(context);
        }
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      controller: passwordcontroller,
      autofocus: false,
      obscureText: vis,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      // onSaved: (value) => passwordcontroller = value,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
    final phoneField = TextFormField(
      controller: phonenumbercontroller,
      autofocus: false,

      validator: (value) => value!.isEmpty ? "Please enter phonenumber" : null,
      // onSaved: (value) => passwordcontroller = value,
      decoration: const InputDecoration(
        labelText: "Phone number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/phone.svg"),
      ),
    );
    final usernameField = TextFormField(
      controller: usernamecontroller,
      validator: (onValidateVal) {
        if (onValidateVal!.isEmpty) {
          return 'username can\'t be empty';
        }
        return null;
      },
      autofocus: false,
      decoration: const InputDecoration(
        labelText: "User Name",
        hintText: "Enter username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
    final emailField = TextFormField(
      controller: emailcontroller,
      validator: (onValidateVal) {
        if (onValidateVal!.isEmpty) {
          return 'email can\'t be empty';
        }
        return null;
      },
      autofocus: false,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.purple, Colors.purpleAccent]),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/WB5.png',
                                width: 175,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      Text("Register Account", style: headingStyle),
                      const Text(
                        "Complete your details or continue \nwith social media",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.025),
                      usernameField,
                      SizedBox(height: getProportionateScreenHeight(10)),
                      phoneField,
                      SizedBox(height: getProportionateScreenHeight(10)),
                      emailField,
                      SizedBox(height: getProportionateScreenHeight(10)),
                      passwordField,
                      SizedBox(height: getProportionateScreenHeight(20)),
                      DefaultButton(
                        text: "Signup",
                        press: () async {
                          //after the login REST api call && response code ==200
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              'email', emailcontroller.text.toString());
                          prefs.setString(
                              'username', usernamecontroller.text.toString());
                          prefs.setString('phonenumber',
                              phonenumbercontroller.text.toString());

                          prefs.setString("userId", "userId");
                          doRegister(
                              usernamecontroller.text,
                              phonenumbercontroller.text,
                              emailcontroller.text,
                              passwordcontroller.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) => OtpScreen()));
                        },
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocalCard(
                            icon: "assets/icons/google-icon.svg",
                            press: () {},
                          ),
                          SocalCard(
                            icon: "assets/icons/facebook-2.svg",
                            press: () {},
                          ),
                          SocalCard(
                            icon: "assets/icons/twitter.svg",
                            press: () {},
                          ),
                        ],
                      ),
                    ]),
              ),
            ))));
  }
}
