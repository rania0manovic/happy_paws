import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic> data = {};
  bool error = false;

  Future<void> login() async {
    try {
      final response = await AuthService().signIn(data);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonResponse['token'].toString());
        context.router.push(const ClientLayout());
      } else if (response.statusCode == 403) {
        setState(() {
          error = true;
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            const Center(
                child: Image(
              image: AssetImage("assets/images/cat1.png"),
              height: 180,
              width: 180,
            )),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Happy paws",
                style: TextStyle(
                  fontSize: 35,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 30),
              child: Text(
                "Please fill out the form below with correct information to login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w300,
                    fontFamily: "GilroyLight"),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 60, right: 60, top: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      inputField('Email', 'email'),
                      inputField('Password', 'password', isObscure: true),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: error,
                        child: const Text(
                          "Wrong email or password! Please try again.",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.error,
                              fontWeight: FontWeight.w300,
                              fontFamily: "GilroyLight"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => login(),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primary),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 0, left: 0),
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () => context.router.push(const RegisterRoute()),
              child: Padding(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 30),
                child: Text(
                  "Not a member yet? Register here.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w300,
                      fontFamily: "GilroyLight"),
                ),
              ),
            )
          ]),
    ));
  }

  Column inputField(String label, String key, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(
              fontFamily: 'GilroyLight',
              fontWeight: FontWeight.w300,
              fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 49,
          child: TextField(
            onChanged: (value) {
              setState(() {
                data[key] = value;
              });
            },
            style: TextStyle(color: error ? AppColors.error :Colors.black),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                filled: true,
                fillColor: error ? AppColors.dimError : AppColors.dimWhite,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:  BorderSide(
                      color: error ? AppColors.error :
                          AppColors.primary, 
                      width: 5.0, 
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
