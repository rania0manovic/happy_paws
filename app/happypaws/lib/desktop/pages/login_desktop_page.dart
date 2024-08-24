import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/input_field.dart';
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
  Map<String, dynamic> data = {'adminPanel': true};
  bool isLoading = true;
  bool isDisabledButton = false;

  @override
  void initState() {
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
      setState(() {
        isDisabledButton = true;
      });
      final response = await AuthService().signIn(data);
      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded =
            Jwt.parseJwt(response.data['token']);
        if (decoded['Role'] == 'Admin' || decoded['Role'] == 'Employee') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', response.data['token'].toString());
          setState(() {
            isDisabledButton = false;
          });
          if (mounted) {
            context.router.push(const AdminLayout());
          }
        }
      } else {
        setState(() {
          error = true;
          isDisabledButton = false;
        });
      }
    } on DioException {
      setState(() {
        error = true;
        isDisabledButton = false;
      });
      if (!mounted) return;
      ToastHelper.showToastError(
          context, "An error has occured! Please try again later.");
      rethrow;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Spinner()
          : SafeArea(
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
                        child: Form(
                          key: _formKey,
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
                              InputField(
                                label: "Email:",
                                onChanged: (value) {
                                  data['email'] = value;
                                },
                                labelColor: AppColors.dimWhite,
                                fillColor: AppColors.dimWhite,
                              ),
                              InputField(
                                label: "Password:",
                                onChanged: (value) {
                                  data['password'] = value;
                                },
                                labelColor: AppColors.dimWhite,
                                isObscure: true,
                                fillColor: AppColors.dimWhite,
                              ),
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
                                isDisabled: isDisabledButton,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                label: "Login",
                                width: double.infinity,
                                fontSize: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
