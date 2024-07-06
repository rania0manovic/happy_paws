import 'package:flutter/material.dart';

class MessageNotifier extends ChangeNotifier {
  String _message = '';

  String get message => _message;

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }
   
}
class NotificationStatus extends ChangeNotifier {
  bool _hasNewNotification = false;
  bool _isShowingNotifications = false;


  bool get hasNewNotification => _hasNewNotification;
  bool get isShowingNotifications => _isShowingNotifications;

  void setHasNewNotification(bool value) {
    _hasNewNotification = value;
    notifyListeners();
  }
    void setIsShowingNotifications(bool value) {
    _isShowingNotifications = value;
    notifyListeners();
  }
}