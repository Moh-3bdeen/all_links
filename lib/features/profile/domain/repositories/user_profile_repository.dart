import 'dart:developer';
import 'package:all_links/core/api/api_setting.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_base_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_connection.dart';
import '../../../links/data/models/link_model.dart';

class UserProfileRepository {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static final NetworkConnection networkConnection = NetworkConnection();

  static Future<Either<Exception, List<Link>>> getUserLinks(String userToken) async {
    if (await networkConnection.isConnected) {
      try {
        final response = await _helper.get(url: ApiSetting.getUserLinks, header: {
          'Authorization': 'Bearer $userToken',
        });
        try{
          List<Link> links = [];
          Map<String, dynamic> result = response;
          for (var element in (result["links"] as List)) {
            links.add(Link.fromJson(element));
          }
          return Right(links);
        }catch(error){
          log("Error 27 is: $error");
          return Left(FetchDataException(error.toString()));
        }
      } catch (e) {
        log("Error 31 is: $e");
        return Left(FetchDataException());
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }
}
