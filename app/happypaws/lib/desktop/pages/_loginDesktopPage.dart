import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/PrimaryButton.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginDesktopPage extends StatefulWidget {
  const LoginDesktopPage({super.key});

  @override
  State<LoginDesktopPage> createState() => _LoginDesktopPageState();
}

class _LoginDesktopPageState extends State<LoginDesktopPage> {
  bool error = false;
  Map<String, dynamic> data = {};
  bool isLoading = true;

  @override void initState(){
    super.initState();
    checkIfLogged();
  }

  Future<void> checkIfLogged() async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      if (!mounted) return;
      context.router.push(const AdminLayout());
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> login() async {
    try {
      final response = await AuthService().signIn(data);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        final Map<String, dynamic> decoded =
            Jwt.parseJwt(jsonResponse['token']);
        if (decoded['Role'] == 'Admin' || decoded['Role'] == 'Employee') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', jsonResponse['token'].toString());
          if (mounted) {
            context.router.push(const AdminLayout());
          }
        } else {
          setState(() {
            error = true;
          });
          return;
        }
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
      body:  isLoading ? Spinner() : SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/images/close-up-veterinarian-taking-care-dog.jpg"))),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: const Color.fromARGB(235, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      inputField('Email:', 'email'),
                      inputField('Password:', 'password', isObscure: true),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: error,
                        child: const Text(
                          "Wrong login data or access not granted.",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      PrimaryButton(
                        onPressed: () => login(),
                        label: "Login",
                        width: double.infinity,
                        fontSize: 20,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column inputField(String label, String key, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: TextField(
            onChanged: (value) {
              setState(() {
                data[key] = value;
              });
            },
            style: TextStyle(color: error ? AppColors.error : Colors.black),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                filled: true,
                fillColor: error ? AppColors.dimError : AppColors.dimWhite,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: error ? AppColors.error : AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
