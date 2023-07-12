import 'dart:convert';
import 'package:all_links/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Keys {
  isLogged,
  id,
  name,
  email,
  token,
  lat,
  long,
}

class SharedPrefController {
  static late SharedPreferences sharedPreferences;

  // static SharedPrefController? _instance;

  SharedPrefController._();

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setUserData(Map<String, dynamic> user) async {
    await sharedPreferences.setBool(Keys.isLogged.name, true);
    await sharedPreferences.setInt(Keys.id.name, user["user"]["id"]);
    await sharedPreferences.setString(Keys.name.name, user["user"]["name"]);
    await sharedPreferences.setString(Keys.email.name, user["user"]["email"]);
    await sharedPreferences.setDouble(Keys.long.name, double.parse("${user["user"]["long"] ?? 0.0}"));
    await sharedPreferences.setDouble(Keys.lat.name, double.parse("${user["user"]["lat"] ?? 0.0}"));
    await sharedPreferences.setString(Keys.token.name, user["token"]);
  }

  UserModel getUserData(String? userJson) {
    return UserModel.fromJson(jsonDecode(userJson!));
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<void> clearData() async {
    await sharedPreferences.remove(Keys.isLogged.name);
    await sharedPreferences.remove(Keys.id.name);
    await sharedPreferences.remove(Keys.name.name);
    await sharedPreferences.remove(Keys.email.name);
    await sharedPreferences.remove(Keys.long.name);
    await sharedPreferences.remove(Keys.lat.name);
    await sharedPreferences.remove(Keys.token.name);
  }
}
