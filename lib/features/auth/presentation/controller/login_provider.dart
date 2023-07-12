import 'dart:developer';
import 'package:all_links/core/alert_dialog/all_dialogs.dart';
import 'package:all_links/core/constants/router_list.dart';
import 'package:all_links/core/error/exception.dart';
import 'package:flutter/material.dart';
import '../../../../infrastacture/shared_preferences.dart';
import '../../domain/repositories/login_repositories.dart';

class LoginProvider extends ChangeNotifier {
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

  login(BuildContext context) async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if(email.isNotEmpty && password.isNotEmpty){
      if(email.contains("@") && !email.startsWith("@") && !email.endsWith("@")){
        if(password.length > 5){
          changeShowProgress();
          var loginRepo = await LoginRepository.login(email, password);
          changeShowProgress();
          loginRepo.fold((error) {
            log("Error type is: ${error.runtimeType.toString()}");
            if(error is NoInternetException){
              AllDialogs.alertDialog(context, error.message, "Check your wifi and then login", true);
            }
            if(error is FetchDataException){
              AllDialogs.alertDialog(context, error.message, "", true);
            }
            if(error is BadRequestException){
              AllDialogs.alertDialog(context, error.message, "fff", true);
            }
            if(error is WrongPasswordOrEmailException){
              AllDialogs.alertDialog(context, error.message, "Email or password is wrong !", true);
            }
          }, (user) {
            try{
              SharedPrefController.setUserData(user);
              Navigator.pushReplacementNamed(context, RouterList.pageViewApp);
            }catch(error){
              SharedPrefController.clearData();
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
