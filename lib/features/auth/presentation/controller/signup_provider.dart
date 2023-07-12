import 'dart:convert';
import 'dart:developer';

import 'package:all_links/features/auth/data/models/user_model.dart';
import 'package:all_links/features/auth/domain/repositories/signup_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/alert_dialog/all_dialogs.dart';
import '../../../../core/constants/router_list.dart';
import '../../../../core/error/exception.dart';
import '../../../../infrastacture/shared_preferences.dart';

class SignupProvider extends ChangeNotifier{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isShowProgress = false;
  bool isVisiblePassword = false;

  changeShowProgress() {
    isShowProgress = !isShowProgress;
    notifyListeners();
  }

  changeVisiblePassword() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  signup(BuildContext context) async {
    String name = nameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
      if(email.contains("@") && !email.startsWith("@") && !email.endsWith("@")){
        if(password.length > 5){
          changeShowProgress();
          var signupRepo = await SignupRepository.signup(name, email, password);
          changeShowProgress();
          signupRepo.fold((error) {
            log("Error type is: ${error.runtimeType.toString()}");
            if(error is NoInternetException){
              AllDialogs.alertDialog(context, error.message, "Check your wifi and then signup", true);
            }
            if(error is FetchDataException){
              AllDialogs.alertDialog(context, error.message, "", true);
            }
            if(error is BadRequestException){
              AllDialogs.alertDialog(context, error.message, "The email has already been taken.", true);
            }
            if(error is UnauthorisedException){
              AllDialogs.alertDialog(context, error.message, "", true);
            }
          }, (user) {
            try{
              SharedPrefController.setUserData(user);
              Navigator.pushNamedAndRemoveUntil(context, RouterList.pageViewApp, (route) => false);
            }catch(error){
              SharedPrefController.clearData();
              log("Error: ${error}");
              Map<String, dynamic> errors = jsonDecode(error.toString());
              AllDialogs.alertDialog(context, "Change email", "${errors["message"]}", true);
            }
          });
        }else{
          AllDialogs.alertDialog(context, "Password is short", "Please write password longer than 5 characters.", true);
        }
      }else{
        AllDialogs.alertDialog(context, "Error email!", "Please write valid email.", true);
      }
    }else{
      const snackBar = SnackBar(
        content: Text('Fill all fields !!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}