import 'dart:io';

class PlatformInfo {
  bool isAppOS() {
    return Platform.isIOS || Platform.isAndroid;
  }

  bool isDesktopOS() {
    return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  }
}
