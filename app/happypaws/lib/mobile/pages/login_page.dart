import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
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
  final _formKey = GlobalKey<FormState>();
  Map<String, bool> errorStates = {};
  bool isDisabledButton = false;

  Future<void> login() async {
    try {
      setState(() {
        isDisabledButton = true;
      });
      final response = await AuthService().signIn(data);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['token'].toString());
        setState(() {
          isDisabledButton = false;
        });
        if (mounted) {
          context.router.push(const ClientLayout());
        }
      }
    } on DioException {
      setState(() {
        error = true;
        isDisabledButton = false;
      });

      rethrow;
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
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text(
                "Please fill out the form below with correct information to login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Form(
                    key: _formKey,
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PrimaryButton(
                          isDisabled: isDisabledButton,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          label: "Login",
                          fontSize: 18,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                )),
            GestureDetector(
              onTap: () => context.router.push(const RegisterRoute()),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  "Not a member yet? Register here.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          child: TextFormField(
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              setState(() {
                data[key] = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  errorStates[key] = true;
                });
                return 'This field is required';
              }
              setState(() {
                errorStates[key] = false;
              });
              return null;
            },
            style: TextStyle(color: error ? AppColors.error : Colors.black),
            obscureText: isObscure ? true : false,
            decoration: InputDecoration(
                errorStyle:
                    const TextStyle(color: AppColors.error, fontSize: 14),
                filled: true,
                fillColor: error ? AppColors.dimError : AppColors.fill,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
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
