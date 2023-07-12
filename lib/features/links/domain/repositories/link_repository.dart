import 'dart:convert';
import 'dart:developer';
import 'package:all_links/core/api/api_setting.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_base_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_connection.dart';
import '../../../../infrastacture/shared_preferences.dart';
import '../../data/models/link_model.dart';

class LinkRepository {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static final NetworkConnection networkConnection = NetworkConnection();

  static String userToken = SharedPrefController.getData(key: Keys.token.name);

  static Future<Either<Exception, List<Link>>> getLinkList() async {
    if (await networkConnection.isConnected) {
      try {
        final response = await _helper.get(url: ApiSetting.getUserLinks, header: {
          'Authorization': 'Bearer $userToken',
        });
        try{
          List<Link> links = [];
          Map<String, dynamic> result = response;
          (result["links"] as List).forEach((element) {
            links.add(Link.fromJson(element));
          });
          return Right(links);
        }catch(error){
          log("Error 31 is: ${error}");
          return Left(FetchDataException(error.toString()));
        }
      } catch (e) {
        log("Error 35 is: ${e}");
        return Left(FetchDataException());
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }

  ////////////////////////////////////

  static Future<Either<Exception, Link>> addLink(String title, String link, String userName) async {
    if (await networkConnection.isConnected) {
      try {
        log("Token is: $userToken");
        final response = await _helper.post(url: ApiSetting.addNewLinks, header: {
          'Authorization': 'Bearer $userToken',
        }, body: {
          "title": title,
          "link": link,
          "username": userName,
          // "isActive": 0,
        });
        log("Response is: ${response["link"]}");
        return Right(Link.fromJson(response["link"]));
      } catch (error) {
        log(error.toString());
        return Left(FetchDataException("Somethings error"));
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }

  ////////////////////////////////////

  static Future<Either<Exception, String>> updateLink(int id, String title, String link, String userName) async {
    if (await networkConnection.isConnected) {
      try {
        log("Token is: $userToken");
        final response = await _helper.put(url: "${ApiSetting.updateLink}$id", header: {
          'Authorization': 'Bearer $userToken',
        }, body: {
          "title": title,
          "link": link,
          "username": userName,
          // "isActive": 0,
        });
        log("Response is: ${response["message"]}");
        return Right(response["message"]);
      } catch (error) {
        log(error.toString());
        return Left(FetchDataException("Somethings error"));
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }

  ////////////////////////////////////

  static Future<Either<Exception, String>> deleteLink(int id) async {
    if (await networkConnection.isConnected) {
      try {
        log("Token is: $userToken");
        final response = await _helper.delete(
          url: "${ApiSetting.deleteLink}$id",
          header: {
            'Authorization': 'Bearer $userToken',
          },
          body: {},
        );
        log("Response is: ${response["message"]}");
        return Right(response["message"]);
      } catch (error) {
        log(error.toString());
        return Left(FetchDataException("Somethings error"));
      }
    } else {
      return Left(NoInternetException("No Internet Connection"));
    }
  }
}
