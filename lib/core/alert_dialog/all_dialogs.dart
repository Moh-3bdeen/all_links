import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../infrastacture/shared_preferences.dart';
import '../constants/router_list.dart';

class AllDialogs{

  static alertDialog(BuildContext context, String title, String desc, bool isError){
    Alert(
      context: context,
      type: isError ? AlertType.error : AlertType.success,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();

  }

  ///////////////////////////////////////

  static logoutDialog(BuildContext context){
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Logout !",
      desc: "Do you want logout ?",
      buttons: [
        DialogButton(
          onPressed: (){
            SharedPrefController.clearData();
            Navigator.pushNamedAndRemoveUntil(context, RouterList.loginScreen, (route) => false);
          },
          width: 120,
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();

  }

  ///////////////////////////////////////

}