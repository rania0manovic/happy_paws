import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/buttons/primary_button.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    checkIfLogged();
  }

  Future<void> checkIfLogged() async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      if (!mounted) return;
      context.router.push(const ClientLayout());
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Spinner()
          : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              
                const Center(
                    child:
                        Image(image: AssetImage("assets/images/cat1.png"))),
                Column(
                  children: [
                    Text(
                      "Happy paws",
                      style: TextStyle(
                        fontSize: 40,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "Keep your paw friends happy and healthy with us.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                PrimaryButton(
                    onPressed: () => AutoRouter.of(context)
                        .push(const RegisterRoute()),
                    label: "Join us today", width: double.infinity, fontSize: 22, ),
                const SizedBox(
                  height: 40,
                ),
              ]),
          ),
    );
  }
}
