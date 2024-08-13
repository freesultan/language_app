import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
    
  String? _username;
  String? _email;
  String? _avatarUrl;

   
  String? get username => _username;
  String? get email => _email;
  String get avatarUrl => _avatarUrl ?? 'https://avatar.iran.liara.run/public';

  bool get isLoggedIn => _username != null && _email != null;

  void setUser(String username, String email) {
    _username = username;
    _email = email;
    notifyListeners();
  }

  void clearUser() {
    
    _username = null;
    _email = null;
    notifyListeners();
  }
}
