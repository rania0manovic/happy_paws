
import 'package:flutter/material.dart';
import 'package:happypaws/routes/app_router.dart';

class MyAppMobile extends StatelessWidget {
  const MyAppMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "SF Pro Display"),
      routerConfig: appRouter.config(),
    );
  }
}