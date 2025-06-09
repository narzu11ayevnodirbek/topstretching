import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  Dio dioClient =
      Dio(
          BaseOptions(
            baseUrl: "",
            receiveTimeout: Duration(seconds: 60),
            connectTimeout: Duration(seconds: 60),
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              log("METHOD TYPE: ${options.method}");
              log("METHOD PATH: ${options.path}");
              log("REQUEST BODY: ${options.data}");
              return handler.next(options);
            },
            onResponse: (response, handler) {
              log("RESPONSE STATUS CODE: ${response.statusCode}");
              log("RESPONSE DATA: ${response.data}");
              return handler.next(response);
            },
            onError: (error, handler) {
              log("ON ERROR: ${error.error}");
              return handler.next(error);
            },
          ),
        );
}
