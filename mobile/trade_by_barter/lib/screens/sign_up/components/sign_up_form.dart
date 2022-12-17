import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_prefix_icon.dart';
import 'package:shop/components/default_button.dart';
import 'package:shop/components/form_error.dart';
import 'package:shop/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop/screens/sign_in/sign_in_screen.dart';
import 'package:shop/services/networkhelper.dart';
import '../../../models/user_model.dart';
import '../../../services/user_provider.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/enums.dart';
import '../../../widgets/size_config.dart';
import '../../otp/otp_screen.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool vis = true;
  final _formKey = new GlobalKey<FormState>();
  NetworkHelper networkHelper = NetworkHelper();
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController phonenumbercontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  String? errorText;
  bool validate = false;
  bool circular = false;

  bool remember = false;
  final List<String?> errors = [];

  // Replace with your API's sign up endpoint
  String signUpUrl =
      "tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/register";

  signup() async {
    // Replace with the user's sign up information
    Map<String, String> signUpData = {
      'email': emailcontroller.text.toString(),
      'password': passwordcontroller.text.toString(),
      'phonenumber': phonenumbercontroller.text.toString(),
      'username': usernamecontroller.text.toString()
    };

// Make a POST request to the sign up endpoint
    var response = await http.post(Uri.parse(signUpUrl), body: signUpData);

// Check the status code of the response to determine whether the sign up was successful
    if (response.statusCode == 200) {
      // If the sign up was successful, parse the API token from the response
      // var apiToken = response.body["token"];

      // Store the API token for future authentication
      // storeApiToken(apiToken);
    } else {
      // If the sign up was not successful, handle the error
      // handleSignUpError(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
              text: "Register",
              press: () {
                if (_formKey.currentState!.validate()) {
                  //send to server
                  print('validated');
                }
                // if all are valid then go to Otp screen
                Navigator.pushNamed(context, SignInScreen.routeName);
              }),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      autofocus: false,
      obscureText: vis,

      controller: passwordcontroller,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      // onSaved: (value) => password = value!,
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
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailcontroller,
      validator: (value) {
        if (value!.isEmpty) return 'email cannot be empty';
        if (!value.contains('0')) return 'email is invalid';

        return null;
      },

      // onSaved: (value) => email = value!,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: phonenumbercontroller,
      // onSaved: (value) => phonenumber = value!,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/phone.svg"),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      controller: usernamecontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'username cannot be empty';
        }
        return null;
      },
      // onSaved: (value) => username = value!,
      decoration: InputDecoration(
        errorText: validate ? null : errorText,
        labelText: "User Name",
        hintText: "Choose your username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
