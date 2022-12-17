import 'dart:convert';
import 'dart:io';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/components/custom_prefix_icon.dart';
import 'package:shop/components/form_error.dart';
import 'package:shop/components/keyboard.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop/screens/login_success/login_success_screen.dart';
import 'package:shop/screens/otp/otp_screen.dart';
import 'package:shop/widgets/enums.dart';

import '../../../components/default_button.dart';
import '../../../services/user_provider.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool? remember = false;
  bool _loading = false;
  String? username, password;
  bool isApicallProcess = false;

  // TextEditingController _username = new TextEditingController();
  // TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);

    TextFormField buildUserNameFormField() {
      return TextFormField(
        validator: emaildValidator,
        onSaved: (value) => username = value!,
        autofocus: false,
        decoration: const InputDecoration(
          labelText: "User Name",
          hintText: "Enter username",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      );
    }

    TextFormField buildPasswordFormField() {
      return TextFormField(
        validator: (value) => value!.isEmpty ? "Please enter password" : null,
        autofocus: false,
        obscureText: true,
        onSaved: (value) => password = value!,
        decoration: const InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: CustomPrefixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      );
    }

    return Form(
      key: globalKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
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
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Color(0xFF8F79FF), fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
              text: "Continue",
              press: () {
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }),
        ],
      ),
    );
  }
}
