import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:happypaws/common/services/AuthService.dart';

@RoutePage()
class RegisterVerificationPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const RegisterVerificationPage({super.key, required this.user});

  @override
  State<RegisterVerificationPage> createState() =>
      _RegisterVerificationPageState();
}

class _RegisterVerificationPageState extends State<RegisterVerificationPage> {
  String code = '';
  bool error = false;
  bool succes = false;
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(4, (index) => TextEditingController());

    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < _controllers.length - 1) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      });
    }
  }

  Future<void> sendCodeAgain() async {
    try {
      final response = await AuthService().sendEmailVerification(widget.user);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> verifyCode() async {
    code = _controllers.map((controller) => controller.text).join();
    var extendedUser = {...widget.user, 'verificationCode': code};

    final response = await AuthService().signUp(extendedUser);
    if (response.statusCode == 200) {
      setState(() {
        succes = true;
      });
    } else {
      setState(() {
        error = true;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }

    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            succes
                ? Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80, top: 0),
                        child: Text(
                          "Congratulations ${widget.user["firstName"]}! Your account has been successfully created. Please login to continue.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w300,
                              fontFamily: "GilroyLight"),
                        ),
                      ),
                       Padding(
                padding: const EdgeInsets.only(top: 250),
                child: GestureDetector(
                  onTap: () =>
                      AutoRouter.of(context).push(const LoginRoute()),
                  child: Container(
                    height: 60,
                    width: 280,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [
                            Color.fromRGBO(63, 13, 132, 1),
                            Color.fromRGBO(63, 13, 132, 1)
                          ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 40, left: 40),
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                )),
                  ],
                )
                : Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 80, right: 80, top: 0),
                        child: Text(
                          "Please insert the verification code that we sent to your email address.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w300,
                              fontFamily: "GilroyLight"),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    4, (index) => inputField(index))),
                          )),
                      Visibility(
                        visible: error,
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 80, right: 80, top: 20),
                          child: Text(
                            "Wrong input! Please try again.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffBA1A36),
                                fontWeight: FontWeight.w300,
                                fontFamily: "GilroyLight"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => sendCodeAgain(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 80, right: 80, top: 20),
                          child: Text(
                            "Didn’t receive it? Send again.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w300,
                                fontFamily: "GilroyLight"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 180,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () => verifyCode(),
                          child: SvgPicture.asset(
                            'assets/icons/long_right_arrow.svg',
                            height: 50,
                            width: 50,
                            color: const Color(0xff3F0D84),
                          ),
                        ),
                      )
                    ],
                  ),
          ]),
    ));
  }

  SizedBox inputField(int index) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        maxLines: 1,
        maxLength: 1,
        style: TextStyle(
            fontSize: 26,
            color: error ? const Color(0xffBA1A36) : const Color(0xff3f0d81)),
        decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: error
                ? const Color.fromARGB(128, 223, 191, 191)
                : const Color(0xfff2f2f2),
            border: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(0, 255, 255, 255),
                  width: 5, 
                ),
                borderRadius: BorderRadius.circular(5)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      error ? const Color(0xffBA1A36) : const Color(0xff3F0D84),
                  width: 5.0, 
                ),
                borderRadius: BorderRadius.circular(5))),
      ),
    );
  }
}
