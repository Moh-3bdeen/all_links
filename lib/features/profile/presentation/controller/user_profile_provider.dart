import 'dart:developer';
import 'package:all_links/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:flutter/material.dart';
import '../../../../core/alert_dialog/all_dialogs.dart';
import '../../../../core/error/exception.dart';
import '../../../links/data/models/link_model.dart';

class UserProfileProvider extends ChangeNotifier{
  int? userId;
  String? userName;
  String? userEmail;
  String? userToken;


  List<Link> allLinks = [];

  bool isGettingData = false;

  changeGettingData() {
    isGettingData = !isGettingData;
    notifyListeners();
  }

  Future<List<Link>> getUserLinks(BuildContext context, String userToken) async {
    if (allLinks.isEmpty) {
      changeGettingData();
      var linksRepo = await UserProfileRepository.getUserLinks(userToken);
      changeGettingData();
      linksRepo.fold((error) {
        log("Error type is: ${error.runtimeType.toString()}");
        if (error is NoInternetException) {
          AllDialogs.alertDialog(context, error.message, "Check your wifi and then open user profile", true);
        }
        if (error is FetchDataException) {
          AllDialogs.alertDialog(context, error.message, "", true);
        }
      }, (links) {
        allLinks = links;
        notifyListeners();
      });
    }
    return allLinks;
  }


}