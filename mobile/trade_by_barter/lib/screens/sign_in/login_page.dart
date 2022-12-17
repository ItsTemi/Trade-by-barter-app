import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/loginModel.dart';
import 'package:shop/services/ApiServices.dart';
import 'package:shop/widgets/constants.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:http/http.dart' as http;
import '../../components/custom_prefix_icon.dart';
import '../../components/default_button.dart';
import '../../components/no_account_text.dart';
import '../../components/socal_card.dart';
import '../../widgets/size_config.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../login_success/login_success_screen.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/sign_in";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  // bool hidePassword = true;
  // String? username;
  // String? password;
  // bool isApicallProcess = false;
  bool? remember = false;
  final formKey = new GlobalKey<FormState>();
  bool vis = true;
  String? apiToken;
  String loginUrl =
      "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/login";
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  bool isLoading = false;

  // Function to store the API token in SharedPreferences
  storeApiToken(String apiToken) async {
    // Get the instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store the API token in SharedPreferences
    prefs.setString('apiToken', apiToken);
  }

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

  doLogin(String username, String password) async {
    setState(() {
      isLoading = true;
    });

    // Replace with the user's sign up information
    var body = json.encode({
      'password': password,
      'username': username,
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };

// Make a POST request to the sign up endpoint
    await http
        .post(Uri.parse(loginUrl), body: body, headers: headers)
        .then((response) {
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        body = jsonDecode(response.body);
        var apiToken = body['token'];
        storeApiToken(apiToken);
        print('response status: ${response.statusCode} ');
        print('response status: ${response.body} ');
        if (body != null) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext ctx) => LoginSuccessScreen()));
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
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                vis = !vis;
              });
            },
            icon: Icon(
                vis ? Icons.visibility_off_rounded : Icons.visibility_rounded)),
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/Lock.svg"),
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
      // onSaved: (onSavedVal) {
      //   onSavedVal = username;
      // },
      autofocus: false,
      decoration: const InputDecoration(
        labelText: "User Name",
        hintText: "Enter username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );

    final forgotLabel = Row(
      children: [
        Checkbox(
          value: remember,
          activeColor: primaryColor,
          onChanged: (value) {
            setState(() {
              remember = value;
            });
          },
        ),
        const Text("Remember me"),
        const Spacer(),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
          child: const Text(
            "Forgot Password",
            style: TextStyle(
                color: Color(0xFF8F79FF), fontWeight: FontWeight.w400),
          ),
        )
      ],
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
                        decoration: BoxDecoration(
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
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(28),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sign in with your email and password  \nor continue with social media",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.025),
                      usernameField,
                      SizedBox(height: getProportionateScreenHeight(10)),
                      passwordField,
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8)),
                        child: forgotLabel,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      DefaultButton(
                          text: "Login",
                          press: () async {
                            //after the login REST api call && response code ==200
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.setString(
                                'username', usernamecontroller.text.toString());

                            doLogin(usernamecontroller.text,
                                passwordcontroller.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        LoginSuccessScreen()));
                          }),
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
                      SizedBox(height: getProportionateScreenHeight(20)),
                      NoAccountText(),
                    ]),
              ),
            ))));
  }
}
