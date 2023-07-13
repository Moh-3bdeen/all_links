import 'dart:developer';
import 'package:all_links/features/active_sharing/data/models/active_sharing_model.dart';
import 'package:all_links/features/active_sharing/domain/active_sharing_repository.dart';
import 'package:flutter/material.dart';
import '../../../../core/alert_dialog/all_dialogs.dart';
import '../../../../core/error/exception.dart';
import '../../../../infrastacture/shared_preferences.dart';

class ActiveSharingProvider extends ChangeNotifier{
  int? userId = SharedPrefController.getData(key: Keys.id.name) ?? 0;

  bool isGettingData = false;
  bool isActive = false;
  List<dynamic> allNearestUser = [];

  changeActiveValue() {
    isActive = !isActive;
    notifyListeners();
  }

  changeGettingData() {
    isGettingData = !isGettingData;
    notifyListeners();
  }

  setActiveSharing(BuildContext context, String type) async {
    changeGettingData();
    var linkRepo = await ActiveSharingRepository.setActiveSharing(userId!, type);
    changeGettingData();
    linkRepo.fold((error) {
      log("Error type is: ${error.runtimeType.toString()}");
      if (error is NoInternetException) {
        AllDialogs.alertDialog(context, error.message, "Check your wifi and then open app", true);
      }
      if (error is FetchDataException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }
      if (error is ServerException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }
    }, (map) {
      log("map[activeSharing]: ${map}");

      Map<String, dynamic> activeSharing = map;
    });
  }

  ///////////////////////////////

  removeActiveSharing(BuildContext context, int id) async {
    var linkRepo = await ActiveSharingRepository.removeActiveSharing(id);
    linkRepo.fold((error) {
      log("Error type is: ${error.runtimeType.toString()}");
      if (error is NoInternetException) {
        AllDialogs.alertDialog(context, error.message, "Check your wifi and then open app", true);
      }
      if (error is FetchDataException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }
      if (error is ServerException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }
    }, (isDeleted) {
      log("You deleted from active sharing ? $isDeleted");
    });
  }

  ///////////////////////////////

  nearestSender(BuildContext context, int id) async {
    var linkRepo = await ActiveSharingRepository.nearestSender(id);
    linkRepo.fold((error) {
      log("Error type is: ${error.runtimeType.toString()}");
      if (error is NoInternetException) {
        AllDialogs.alertDialog(context, error.message, "Check your wifi and then open app", true);
      }
      if (error is FetchDataException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }
      if (error is ServerException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }
    }, (nearestSender) {
      try{
        allNearestUser = nearestSender;
        log("allNearestUser is: ${allNearestUser.length}");
      }catch(error){
        log("Error is: $error");
      }
    });
  }

  ///////////////////////////////

}