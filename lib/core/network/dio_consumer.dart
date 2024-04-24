import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:promina_task/core/error/exception.dart';
import 'package:promina_task/core/network/api_constant.dart';
import 'package:promina_task/core/network/api_consumer.dart';
import 'package:promina_task/core/network/api_interceptors.dart';
import 'package:promina_task/core/network/status_code.dart';
import "package:promina_task/injection_container.dart" as di;

class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = ApiConstant.baseUrl
      ..responseType = ResponseType.plain
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppInterceptors>());
    if(kDebugMode){
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }
  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, String? token}) async {
    try {
      final response = await client.get(path,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      return _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      String? token,
      bool? formDataIsEnabled}) async {
    try {
      final response = await client.post(path, data: body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future postFile(String path,
      {bool? isFormData,
      Map<String, dynamic>? queryParameters,
      String? token,
      Map<String, dynamic>? formData}) async {
    try {
      final response = await client.post(path,
          data: isFormData! ? FormData.fromMap(formData!) : formData,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = json.decode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioException error) {
    if (error.type
        case DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout ||
            DioException.receiveTimeout) {
      throw const FetchDataException();
    } else if (error.type case DioExceptionType.values) {
      switch (error.response?.statusCode) {
        case StatusCode.badRequest:
          throw const BadRequestException();
        case StatusCode.unauthorized:
        case StatusCode.forbidden:
          throw const UnauthorizedException();
        case StatusCode.notFound:
          throw const NotFoundException();
        case StatusCode.confilct:
          throw const ConflictException();

        case StatusCode.internalServerError:
          throw const InternalServerErrorException();
      }
    } else if (error.type case DioExceptionType.cancel) {
    } else if (error.type case DioExceptionType.unknown) {
      throw const NoInternetConnectionException();
    } else if (error.type
        case DioExceptionType.receiveTimeout ||
            DioExceptionType.badCertificate) {}
  }
}
