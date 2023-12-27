import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';


@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}



class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                  fontWeight: FontWeight.w500,
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
                    fontWeight: FontWeight.w300,
                    fontFamily: "GilroyLight"),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 120),
                child: GestureDetector(
                  onTap: () =>
                      AutoRouter.of(context).push(const ClientLayout()),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 40, left: 50),
                          child: Text(
                            "Search now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icons/search.svg",
                          height: 40,
                          width: 40,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () => context.router.push(const RegisterRoute()),
              child: const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "Join us today!",
                  style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w300,
                      fontFamily: "GilroyLight"),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
