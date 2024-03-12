import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    checkIfLogged();
  }

  Future<void> checkIfLogged() async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      if (!context.mounted) return;
      context.router.push(const ClientLayout());
    }
    else {
      setState(() {
      isLoading=false;
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? const Spinner() :  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          children: [
            const Center(
                child: Image(image: AssetImage("assets/images/cat1.png"))),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Happy paws",
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xff3F0D84),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 30),
              child: Text(
                "Keep your paw friends happy and healthy with us.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 120),
                child: GestureDetector(
                  onTap: () =>
                      AutoRouter.of(context).push(const RegisterRoute()),
                  child: Container(
                    height: 68,
                    width: 289,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [
                            Color.fromRGBO(63, 13, 132, 1),
                            Color.fromRGBO(63, 13, 132, 0.8)
                          ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 40, left: 50),
                          child: Text(
                            "Join us today",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 40,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            // GestureDetector(
            //   onTap: () => context.router.push(const LoginRoute()),
            //   child: const Padding(
            //     padding: EdgeInsets.only(top: 0),
            //     child: Text(
            //       "Already a member? Login here.",
            //       style: TextStyle(
            //           fontSize: 16,
            //           decoration: TextDecoration.underline,
            //           fontWeight: FontWeight.w500,
            //      ),
            //     ),
            //   ),
            // )
          ],
        ),
      ]),
    );
  }
}
