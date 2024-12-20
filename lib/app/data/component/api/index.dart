import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ti_learning/app/data/component/api/courses.dart';

import '../mine/function/function.dart';
import 'env.dart';
import 'sign.dart';

class API {
  static final url = Env();
  static final _headers = {'Content-Type': 'application/json; charset=utf-8'};
  static final sign = SignAPI();
  static final courses = CoursesAPI();

  static Future<dynamic> httpNetwork({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    bool noRoute = false,
    String? token,
    String method = "GET",
  }) async {
    method = method.toUpperCase();
    if (method != "GET") {
      MyFX.loading;
    }
    debugPrint('url : $url');
    debugPrint('request : ${jsonEncode(data)}');
    final dio = http.Dio();
    http.Response response;
    try {
      method == "POST"
          ? response = await dio.post(
              url,
              data: data,
              options: http.Options(headers: _headers),
            )
          : response = await dio.get(
              url,
              queryParameters: queryParameters,
              options: http.Options(headers: _headers),
            );
    } on http.DioException catch (err) {
      Get.snackbar(err.type.name, err.message ?? '');
      rethrow;
    }

    final body = response.data;

    debugPrint('response : ${jsonEncode(body)}');

    if (method != "GET") {
      Get.back();
    }
    return body;
  }
}
