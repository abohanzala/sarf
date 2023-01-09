import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_exceptions.dart';

class DioClient {
  // ignore: constant_identifier_names
  static const int TIME_OUT_DURATION = 20;
  var storage = GetStorage();
  //GET
  Future<dynamic> get(String api) async {
    var uri = Uri.parse(api);
    try {
      Dio dio = Dio();
      var token = storage.read('user_token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      var response = await dio
          .get(api)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection'.tr, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time'.tr, uri.toString());
    }
  }

  //POST
  Future<dynamic> post([String api = '', dynamic payloadObj,bool? multiForm]) async {
    var uri = Uri.parse(api);
    var payload = multiForm == true? payloadObj : json.encode(payloadObj);
    try {
      Dio dio = Dio();
      var token = storage.read('user_token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      var response = await dio
          .post(api, data: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection'.tr, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time'.tr, uri.toString());
    }
  }

  //DELETE
  //OTHER
  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : '.tr + response.statusCode,
            response.request!.url.toString());
    }
  }
}
