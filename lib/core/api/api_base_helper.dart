import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../error/exception.dart';

class ApiBaseHelper {
  Future<dynamic> get(
      {required String url, required Map<String, String> header}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: header);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Error fetch data');
    }
    return responseJson;
  }

  ////////////////////////////////////////////////

  Future<dynamic> post(
      {required String url,
      required Map<String, dynamic> body,
      required Map<String, String> header,}) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw ServerException('Something Wrong');
    }
    return responseJson;
  }

  ////////////////////////////////////////////////

  Future<dynamic> put(
      {required String url, required Map<String, dynamic> body}) async {
    var responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        body: body,
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  ////////////////////////////////////////////////

  static returnResponse(http.Response response) {
    log("Response body: ${response.body}");
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        return WrongPasswordOrEmailException(jsonDecode(response.body)['message']);
      case 401:
      case 403:
      return UnauthorisedException(jsonDecode(response.body)['message']);
      case 500:
        return ServerException(jsonDecode(response.body)['message']);
      default:
        return FetchDataException(jsonDecode(response.body)['message']);
    }
  }
}
