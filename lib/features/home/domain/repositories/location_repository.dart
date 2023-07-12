import 'dart:developer';
import 'package:all_links/core/api/api_setting.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_base_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_connection.dart';

class LocationRepository {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static final NetworkConnection networkConnection = NetworkConnection();

  static Future<Either<AppException, Map<String, dynamic>>> updateLocation(String lat, String long) async {
    if (await networkConnection.isConnected) {
      final response = await _helper.post(
        url: ApiSetting.updateUserLocation,
        header: {},
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
