import 'dart:developer';
import 'package:all_links/infrastacture/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../../../core/alert_dialog/all_dialogs.dart';
import '../../../../core/error/exception.dart';
import '../../data/models/link_model.dart';
import '../../domain/repositories/link_repository.dart';

class LinkProvider extends ChangeNotifier {
  List<Link> allMyLinks = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  bool isShowProgress = false;
  bool isGettingData = false;

  changeShowProgress() {
    isShowProgress = !isShowProgress;
    notifyListeners();
  }

  changeGettingData() {
    isGettingData = !isGettingData;
    notifyListeners();
  }

  ////////////////////////////////////////

  Future<List<Link>> getMyLinks(BuildContext context) async {
    if (allMyLinks.isEmpty) {
      changeGettingData();
      var linksRepo = await LinkRepository.getLinkList();
      changeGettingData();
      linksRepo.fold((error) {
        log("Error type is: ${error.runtimeType.toString()}");
        if (error is NoInternetException) {
          AllDialogs.alertDialog(context, error.message, "Check your wifi and then login", true);
        }
        if (error is FetchDataException) {
          AllDialogs.alertDialog(context, error.message, "", true);
        }
      }, (links) {
        allMyLinks = links;
        notifyListeners();
      });
    }
    return allMyLinks;
  }

  ////////////////////////////////////////

  addLink(BuildContext context) async {
    String title = titleController.text.trim();
    String link = linkController.text.trim();
    String userName = SharedPrefController.getData(key: Keys.name.name);

    if (title.isNotEmpty && link.isNotEmpty && userName.isNotEmpty) {
      changeShowProgress();
      var linkRepo = await LinkRepository.addLink(title, link, userName);
      changeShowProgress();
      linkRepo.fold((error) {
        log("Error type is: ${error.runtimeType.toString()}");
        if (error is NoInternetException) {
          AllDialogs.alertDialog(context, error.message, "Check your wifi and then login", true);
        }
        if (error is FetchDataException) {
          AllDialogs.alertDialog(context, error.message, "", true);
        }
      }, (link) {
        titleController.clear();
        linkController.clear();
        AllDialogs.alertDialog(context, "Successful", "Link is added successfully", false);
        allMyLinks.add(link);
        notifyListeners();
      });
    } else {
      const snackBar = SnackBar(
        content: Text('Fill all fields !!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  ////////////////////////////////////////

  updateLink(BuildContext context, Link oldLink) async {
    String title = titleController.text.trim();
    String link = linkController.text.trim();
    String userName = SharedPrefController.getData(key: Keys.name.name);

    if (title.isNotEmpty && link.isNotEmpty && userName.isNotEmpty) {
      changeShowProgress();
      var linkRepo = await LinkRepository.updateLink(oldLink.id!, title, link, userName);
      changeShowProgress();
      linkRepo.fold((error) {
        log("Error type is: ${error.runtimeType.toString()}");
        if (error is NoInternetException) {
          AllDialogs.alertDialog(context, error.message, "Check your wifi and then login", true);
        }
        if (error is FetchDataException) {
          AllDialogs.alertDialog(context, error.message, "", true);
        }
      }, (message) {
        AllDialogs.alertDialog(context, "Successful", "Link is updated successfully", false);

        oldLink.title = title;
        oldLink.link = link;
        allMyLinks[allMyLinks.indexWhere((element) => element.id == oldLink.id)] = oldLink;

        // allMyLinks.map((element){
        //   log(element.toString());
        //   if(element.id == id){
        //     log("True: ${element.toString()}");
        //     element.title = title;
        //     element.link = link;
        //   }
        // });
        notifyListeners();
      });
    } else {
      const snackBar = SnackBar(
        content: Text('Fill all fields !!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  ////////////////////////////////////////

  deleteLink(BuildContext context, Link link) async {
    changeGettingData();
    var linkRepo = await LinkRepository.deleteLink(link.id!);
    changeGettingData();
    linkRepo.fold((error) {
      log("Error type is: ${error.runtimeType.toString()}");
      if (error is NoInternetException) {
        AllDialogs.alertDialog(context, error.message, "Check your wifi and then login", true);
      }
      if (error is FetchDataException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }
    }, (message) {

      // log("Link is deleted successfully");
      AllDialogs.alertDialog(context, "Successful", "Link is deleted successfully", false);
      allMyLinks.remove(link);
      notifyListeners();
    });
  }
}
