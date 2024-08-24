import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:happypaws/common/utilities/platform_info.dart';
import 'package:happypaws/routes/app_router.dart';
import 'mobile/app_mobile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'desktop/app_desktop.dart';
import 'firebase_options.dart';
import 'package:window_manager/window_manager.dart';

GetIt getIt = GetIt.instance;
PlatformInfo platformInfo = PlatformInfo();
String baseUrl = platformInfo.isDesktopOS()
    ? "http://localhost:5118"
    : "http://10.0.2.2:5118";

final apiUrl = const String.fromEnvironment("API_URL", defaultValue: "") == ""
    ? baseUrl
    : const String.fromEnvironment("API_URL");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().init();
  await dotenv.load(fileName: ".env.testing");
  getIt.registerSingleton<AppRouter>(AppRouter());
  if (platformInfo.isAppOS()) {
    runApp(const MyAppMobile());
  } else if (platformInfo.isDesktopOS()) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    runApp(const MyAppDesktop());
  }
}
