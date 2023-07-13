import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/alert_dialog/all_dialogs.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repositories/location_repository.dart';

class LocationProvider extends ChangeNotifier {

  getLocation(BuildContext context) async {
    bool serviceStatus = await Geolocator.isLocationServiceEnabled();

    if (serviceStatus) {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AllDialogs.alertDialog(context, "Location permissions", "Location permissions are denied", true);
        } else if (permission == LocationPermission.deniedForever) {
          AllDialogs.alertDialog(context, "Location permissions", "Location permissions are denied Forever", true);
        } else {
          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          log(position.longitude.toString());
          log(position.latitude.toString());
          await updateLocation(context, position.latitude.toString(), position.longitude.toString());
        }
      } else {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        log(position.longitude.toString());
        log(position.latitude.toString());
        await updateLocation(context, position.latitude.toString(), position.longitude.toString());
      }
    } else {
        AllDialogs.alertDialog(context, "Location permissions", "GPS service is disabled", true);
      print(".");
    }
  }

  ///////////////////////////////////

  updateLocation(BuildContext context, String lat, String long) async {
    var locationRepo = await LocationRepository.updateLocation(lat, long);
    locationRepo.fold((error) {
      log("Error type is: ${error.runtimeType.toString()}");
      if (error is NoInternetException) {
        AllDialogs.alertDialog(context, error.message, "Check your wifi to update your location", true);
      }else if (error is ServerException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }else if (error is FetchDataException) {
        AllDialogs.alertDialog(context, error.message, "", true);
      }else{
        AllDialogs.alertDialog(context, error.message, "", true);
      }
    }, (user) {
      log("Your location: $user}");
    });
  }
}
