import 'package:flutter/material.dart';
import 'package:happypaws/routes/app_router.dart';

final navigatorKey = GlobalKey<ScaffoldMessengerState>();

class MyAppDesktop extends StatelessWidget {
  const MyAppDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "SF Pro Display"),
      routerConfig: appRouter.config(),
      scaffoldMessengerKey: navigatorKey,
    );
  }
}