import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:happypaws/common/services/LocalNotificationService.dart';
import 'package:happypaws/common/utilities/notification_service.dart';
import 'package:happypaws/common/utilities/platform_info.dart';
import 'package:happypaws/routes/app_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'mobile/app_mobile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'desktop/app_desktop.dart';
import 'firebase_options.dart';

GetIt getIt = GetIt.instance;
PlatformInfo platformInfo = PlatformInfo();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
  await LocalNotificationService().setup();
   await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
  await NotificationService().init();
  await dotenv.load(fileName: ".env");
  getIt.registerSingleton<AppRouter>(AppRouter());
  if (platformInfo.isAppOS()) {
    runApp(const MyAppMobile());
  } else if (platformInfo.isDesktopOS()) {
    runApp(const MyAppDesktop());
  }
}
