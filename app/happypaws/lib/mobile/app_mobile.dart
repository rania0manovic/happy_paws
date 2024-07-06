
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/message_notifier.dart';
import 'package:happypaws/routes/app_router.dart';
import 'package:provider/provider.dart';

class MyAppMobile extends StatelessWidget {
  const MyAppMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MultiProvider(
        providers: [
        ChangeNotifierProvider<NotificationStatus>(
          create: (context) => NotificationStatus(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "SF Pro Display"),
        routerConfig: appRouter.config(),
      ),
    );
  }
}