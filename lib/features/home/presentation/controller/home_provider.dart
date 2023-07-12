import 'package:all_links/infrastacture/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isActive = false;
  String? userName = SharedPrefController.getData(key: Keys.name.name);
  String? userEmail = SharedPrefController.getData(key: Keys.email.name);
  String? userToken = SharedPrefController.getData(key: Keys.token.name);

  Map<String, dynamic> qrCode = {
    "id": SharedPrefController.getData(key: Keys.id.name),
    "name": SharedPrefController.getData(key: Keys.name.name),
    "email": SharedPrefController.getData(key: Keys.email.name),
    "token": SharedPrefController.getData(key: Keys.token.name),
  };

  changeActiveValue() {
    isActive = !isActive;
    notifyListeners();
  }
}
