import 'dart:developer';

import 'package:all_links/core/api/api_setting.dart';
import 'package:all_links/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_base_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_connection.dart';

class SignupRepository {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static final NetworkConnection networkConnection = NetworkConnection();

  static Future<Either<AppException, Map<String, dynamic>>> signup(
      String name, String email, String password) async {
    if (await networkConnection.isConnected) {
      final response = await _helper.post(
        url: ApiSetting.signup,
        header: {},
        body: {
          "name": name,
          'email': email,
          'password': password,
          "password_confirmation": password
        },
      );
      try {
        log("Response is: $response");
        Map<String, dynamic> user = response["user"];
        log("response[user] is: ${response["user"]}");
        return Right(response);
      } catch (e) {
        log("Error is: $e");
        return Left(BadRequestException("Something error"));
      }
    }
    return Left(NoInternetException("No Internet Connection"));
  }
}
