import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:getx/app/data/api_url.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../core/utils.dart';
import '../modules/signIn/model/user_login_response_model.dart';
import '../modules/signup/model/region_model.dart';
import 'error/exception.dart';

abstract class RemoteDataSource {
  Future<dynamic> getRequest({required String url, Map<String, dynamic>? body});
  Future<dynamic> postRequest(
      {required String url, required Map<String, dynamic> body, bool isHeaderAvailable});

  Future<String> uploadFile(String filePath, String userId);

  Future<RegionModel> getRegion();
  Future<String> userRegister(Map<String, dynamic> body);
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;
  final _className = 'RemoteDataSourceImpl';

  RemoteDataSourceImpl({required this.client});

  @override
  Future getRequest({required String url, Map<String, dynamic>? body}) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': Utils.getLoggedInUserToken(),
    };

    if (body != null) {
      final uri = Uri.parse(url).replace(queryParameters: body);

      debugPrint("My Get url = $url");
      final clientMethod = client.get(uri, headers: headers);
      final responseJsonBody =
          await callClientWithCatchException(() => clientMethod);
      if (responseJsonBody["success"] == false) {
        final errorMsg = responseJsonBody["message"];
        throw UnauthorisedException(errorMsg, 401);
      } else {
        return responseJsonBody;
      }
    } else {
      final uri = Uri.parse(url);
      debugPrint("My Get url = $url");
      final clientMethod = client.get(uri, headers: headers);
      final responseJsonBody =
          await callClientWithCatchException(() => clientMethod);
      if (responseJsonBody["success"] == false) {
        final errorMsg = responseJsonBody["message"];
        throw UnauthorisedException(errorMsg, 410);
      } else {
        return responseJsonBody;
      }
    }
  }

  @override
  Future postRequest(
      {required String url, required Map<String, dynamic> body, bool isHeaderAvailable = true}) async {
    var headers = <String, String>{};
    if(isHeaderAvailable){
      headers = {
        'Accept': 'application/json',
        'Authorization': Utils.getLoggedInUserToken(),
      };
    }
    final uri = Uri.parse(url);
    debugPrint("My Post url = $url");
    debugPrint("Body = $body");
    final clientMethod =isHeaderAvailable? client.post(uri, body: body, headers: headers): client.post(uri, body: body);
    final responseJsonBody =
        await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 410);
    } else {
      return responseJsonBody;
    }
  }
  @override
  Future<RegionModel> getRegion() async {
    final uri = Uri.parse("http://ip-api.com/json");
    final clientMethod = client.get(
      uri,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);

    if (responseJsonBody["status"] == "success") {
      return RegionModel.fromJson(responseJsonBody);
    } else {
      final errorMsg = responseJsonBody["data"];
      throw DataNotFoundException(errorMsg, 201);
    }
  }

  @override
  Future<String> userRegister(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userRegister);
    //var data = jsonEncode(body);
    print("my urll $uri");
    final clientMethod = client.post(uri, headers: headers, body: body);
    print("my urll $uri");
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    print("demo $responseJsonBody");
    if (responseJsonBody["status"] == 200) {
      Get.snackbar('Message', responseJsonBody["message"]);
      return responseJsonBody["message"];
    } else {
      final errorMsg = responseJsonBody["message"].toString();
      throw UnauthorisedException(errorMsg, 201);
    }
  }

  @override
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogin);

    // var data = jsonEncode(body);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return UserLoginResponseModel.fromJson(responseJsonBody);
    }
  }


  @override
  Future<String> uploadFile(
    String filePath,
    String userId,
  ) async {
    final uri = Uri.parse(RemoteUrls.uploadImage);

    String imageUrl = "";

    final headers = {
      'Accept': 'application/json',
      'Authorization': Utils.getLoggedInUserToken(),
    };
    try {
      var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
        'file_name',
        filePath,
        filename: Utils.shortenFileName(filePath, userId),
      ));
      Utils.loadingDialog(Get.context!);
      var response = await request.send();
      Utils.closeDialog(Get.context!);
      var value = await http.Response.fromStream(response);
      final Map<String, dynamic> body = await json.decode(value.body);
      if (body["success"] == true) {
        imageUrl = body["path"];
      } else {
        imageUrl = 'error';
      }
    } on Exception catch (e) {
      Utils.closeDialog(Get.context!);
      imageUrl = 'error';
      debugPrint(e.toString());
    }
    return imageUrl;
  }

  Future<dynamic> callClientWithCatchException(
      CallClientMethod callClientMethod) async {
    try {
      final response = await callClientMethod();
      if (kDebugMode) {
        print("status code : ${response.statusCode}");
      }
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      throw const NetworkException(
          'Please check your \nInternet Connection', 10061);
    } on http.ClientException {
      ///503 Service Unavailable
      log('http ClientException', name: _className);
      throw const NetworkException('Service unavailable', 503);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormatException('Data format exception', 422);
    } on InternalServerException {
      log('TimeoutException', name: _className);
      throw const InternalServerException('Request timeout', 500);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

        ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

        /// 415 Unsupported Media Type
        throw const DataFormatException('Data format exception');

      case 422:

        ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

        ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occurred while communication with Server',
            response.statusCode);
    }
  }

  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }

  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }
}
