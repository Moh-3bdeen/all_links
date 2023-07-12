import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  bool isShowProgress = false;

}