import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:happypaws/common/services/AuthService.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Map<String, dynamic> user = {};

  Future<void> sendEmailVerificationCode() async {
    try {
      final response = await AuthService().sendEmailVerification(user);
      if (response.statusCode == 200) {
        if(!mounted)return;
        context.router.push(RegisterVerificationRoute(user: user));
      } else if (response.statusCode == 409) {
        throw Exception('User with the same email exists');
      }
    } catch (e) {
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
                  color: Color(0xff3F0D84),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 30),
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
                padding: const EdgeInsets.only(left: 60, right: 60, top: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      inputField('Name', 'firstName'),
                      inputField('Surname', 'lastName'),
                      inputField('Email', 'email'),
                      inputField('Password', 'password', isObscure: true),
                    ],
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () =>sendEmailVerificationCode(),
              child: SvgPicture.asset(
                'assets/icons/long_right_arrow.svg',
                height: 50,
                width: 50,
                color: Color(0xff3F0D84),
              ),
            ),
            GestureDetector(
              onTap: () => context.router.push(const LoginRoute()),
              child: Padding(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 10),
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
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 49,
          child: TextField(
            obscureText: isObscure,
            onChanged: (value) {
              setState(() {
                user[key] = value;
              });
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff2f2f2),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff3F0D84),
                      width: 5.0,
                    ),
                    borderRadius: BorderRadius.circular(10))),
          ),
        )
      ],
    );
  }
}
