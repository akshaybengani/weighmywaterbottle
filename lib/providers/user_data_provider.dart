import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  Future<void> loadUser() async {
    notifyListeners();
  }
}
