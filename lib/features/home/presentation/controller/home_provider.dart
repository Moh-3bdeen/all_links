import 'package:all_links/infrastacture/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isActive = false;
  String? userName = SharedPrefController.getData(key: Keys.name.name);
  String? userEmail = SharedPrefController.getData(key: Keys.email.name);

  changeActiveValue() {
    isActive = !isActive;
    notifyListeners();
  }
}
