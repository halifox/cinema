import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cms_api.dart';

final cmsDioProvider = Provider((ref) {
  const cmsBaseUrl = String.fromEnvironment('CMS_BASE_URL');
  if (cmsBaseUrl.isEmpty) {
    throw StateError('未配置 CMS_BASE_URL，请通过 --dart-define 注入有效的 CMS 服务地址');
  }
  final dio = Dio(
    BaseOptions(baseUrl: cmsBaseUrl, validateStatus: (status) => status == 200),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        final data = response.data;
        if (data is! String) {
          handler.next(response);
          return;
        }

        try {
          response.data = jsonDecode(data);
          handler.next(response);
        } on FormatException catch (error) {
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
              error: error,
              message: 'CMS 返回的内容不是有效 JSON',
            ),
          );
        }
      },
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
  }
  ref.onDispose(() => dio.close(force: true));
  return dio;
});

final cmsApiProvider = Provider((ref) {
  return CmsApi(ref.watch(cmsDioProvider));
});
