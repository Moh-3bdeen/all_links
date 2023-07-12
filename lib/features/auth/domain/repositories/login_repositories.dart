import 'dart:developer';
import 'package:all_links/core/api/api_setting.dart';
import 'package:all_links/infrastacture/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_base_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_connection.dart';

class LoginRepository {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static final NetworkConnection networkConnection = NetworkConnection();

  static Future<Either<AppException, Map<String, dynamic>>> login(
      String email, String password) async {
    if (await networkConnection.isConnected) {
      final response = await _helper.post(
        url: ApiSetting.login,
        header: {},
        body: {'email': email, 'password': password},
      );
      try {
        Map<String, dynamic> user = response["user"];
        return Right(response);
      } catch (e) {
        log("Error is: $e");
        return Left(WrongPasswordOrEmailException("Invalid Credential"));
      }
    }
    log("Line 29");
    return Left(NoInternetException("No Internet Connection"));
  }
}
