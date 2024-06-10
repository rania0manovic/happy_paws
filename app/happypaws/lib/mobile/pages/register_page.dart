import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:happypaws/common/services/AuthService.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Map<String, dynamic> user={};
  bool isDisabledButton = false;

  Future<void> sendEmailVerificationCode() async {
    dynamic response;
    try {
      setState(() {
        isDisabledButton = true;
      });
       response = await AuthService().sendEmailVerification(user);
      if (response.statusCode == 200) {
        setState(() {
          isDisabledButton = false;
        });
        if (!mounted) return;
        context.router.push(RegisterVerificationRoute(user: user));
      } 
    } catch (e) {
         setState(() {
          isDisabledButton = false;
        });
        ToastHelper.showToastError(context, "User with the same email already exists!");
    }
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, bool> errorStates = {};
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
                "Please fill out the form below with correct information to register",
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
                        inputField('Name', 'firstName'),
                        inputField('Surname', 'lastName'),
                        inputField('Email', 'email'),
                        inputField('Password', 'password', isObscure: true),
                         Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: PrimaryButton(
                            disabledWithoutSpinner: isDisabledButton,
                                onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                sendEmailVerificationCode();
                              }
                                },
                               width: double.infinity,
                               fontSize: 20,
                                label: "Next  ➜"),
                          )),
                      ],
                    ),
                  ),
                )),
            GestureDetector(
              onTap: () => context.router.push(const LoginRoute()),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,),
                child: Text(
                  "Already a member? Login here.",
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
              height: 30,
            ),
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
          height: errorStates[key] ?? false
              ? key == 'password'
                  ? 95
                  : 75
              : 50,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  errorStates[key] = true;
                });
                return 'This field is required';
              } else if (isObscure) {
                RegExp passwordRegex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if (!passwordRegex.hasMatch(value)) {
                  setState(() {
                    errorStates[key] = true;
                  });
                  return 'Password must be at least 8 characters with 1 uppercase, 1 number, and 1 special character';
                }
                return null;
              } else {
                setState(() {
                  errorStates[key] = false;
                });
                return null;
              }
            },
            obscureText: isObscure,
            onChanged: (value) {
              setState(() {
                user[key] = value;
              });
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff2f2f2),
                errorStyle:
                    const TextStyle(color: AppColors.error, fontSize: 16),
                errorMaxLines: 3,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
