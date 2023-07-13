import 'dart:developer';
import 'dart:io';

import 'package:all_links/features/active_sharing/data/models/active_sharing_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/api/api_base_helper.dart';
import '../../../core/api/api_setting.dart';
import '../../../core/error/exception.dart';
import '../../../core/network/network_connection.dart';
import '../../../infrastacture/shared_preferences.dart';

class ActiveSharingRepository{
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static final NetworkConnection networkConnection = NetworkConnection();

  static String userToken = SharedPrefController.getData(key: Keys.token.name);

  static Future<Either<Exception, Map<String, dynamic>>> setActiveSharing(int id, String type) async {
    if (await networkConnection.isConnected) {
      try {
        final response = await _helper.post(url: "${ApiSetting.setActiveSharing}$id", header: {
          'Authorization': 'Bearer $userToken',
        }, body: {
          "type": type,
        },);
        log("Response is: ${response["activeSharing"]}");
        return Right(response["activeSharing"]);
      } catch (e) {
        log("Error 30 is: $e");
        return Left(FetchDataException("Somethings error"));
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }

////////////////////////////////////

  static Future<Either<Exception, bool>> removeActiveSharing(int id) async {
    if (await networkConnection.isConnected) {
      try {
        final response = await _helper.delete(url: "${ApiSetting.removeActiveSharing}$id", header: {
          'Authorization': 'Bearer $userToken',
        }, body: {
        },);
        log("Response is: ${response["isDeleted"]}");
        return Right(response["isDeleted"]);
      } catch (e) {
        log("Error 50 is: $e");
        return Left(FetchDataException("Somethings error"));
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }

////////////////////////////////////

  static Future<Either<Exception, List<dynamic>>> nearestSender(int id) async {
    if (await networkConnection.isConnected) {
      try {
        final response = await _helper.get(url: "${ApiSetting.nearestSender}$id", header: {
          'Authorization': 'Bearer $userToken',
        },);
        log("response[nearest-users] is: ${response["nearest-users"]}");
        List<dynamic> nearestListMap = response["nearest-users"];
        // List<ActiveSharingModel> allSender = [];
        // nearestListMap.map((element) => allSender.add(ActiveSharingModel.fromJson(element)));

        log("nearestListMap.length: ${nearestListMap.length}");
        // log("allSender.length: ${allSender.length}");
        return Right(nearestListMap);
      } catch (e) {
        log("Error 73 is: $e");
        return Left(FetchDataException("Somethings error"));
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }

////////////////////////////////////

}