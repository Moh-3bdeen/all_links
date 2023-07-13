import 'dart:developer';
import 'package:all_links/core/api/api_setting.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_base_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_connection.dart';
import '../../../../infrastacture/shared_preferences.dart';

class LocationRepository {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static final NetworkConnection networkConnection = NetworkConnection();

  static String userToken = SharedPrefController.getData(key: Keys.token.name);
  static String userTd = SharedPrefController.getData(key: Keys.id.name).toString();

  static Future<Either<AppException, Map<String, dynamic>>> updateLocation(String lat, String long) async {
    if (await networkConnection.isConnected) {
      final response = await _helper.put(
        url: "${ApiSetting.updateUserLocation}$userTd",
        header: {
          'Authorization': 'Bearer $userToken',
        },
        body: {'lat': lat, 'long': long},
      );
      try {
        Map<String, dynamic> user = response["user"];
        return Right(response);
      } catch (e) {
        log("Error is: $e");
        return Left(ServerException("Somethings error"));
      }
    }
    return Left(NoInternetException("No Internet Connection"));
  }
}
