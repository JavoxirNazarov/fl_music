import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:top_music/feauteres/auth/services/session_store.dart';
import 'package:top_music/resources/constants.dart';

class ApiClient {
  static Future<T> get<T>({
    required String path,
    required T Function(Map<String, dynamic> json) parser,
    bool withAuth = false,
    bool ignoreBaseApi = false,
  }) async {
    try {
      final url = Uri.parse(
        ignoreBaseApi ? path : '${Constants.apiBase}/$path',
      );

      var headers = withAuth
          ? {
              "Authorization": 'Token ${SessionStore.intance.getSession()}',
              "Origin": Constants.apiBase
            }
          : null;

      final response = await http.get(url, headers: headers);

      // print('response');

      _validate(response);

      // print('_validate');

      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      // print('jsonResponse');
      final T result = parser(jsonResponse);

      // print('result');

      return result;
    } on ApiExceptionType {
      rethrow;
    } on SocketException {
      throw ApiException(ApiExceptionType.network);
    } catch (err) {
      print(err.toString());
      throw ApiException(ApiExceptionType.other);
    }
  }

  static Future<T> post<T>({
    required String path,
    required T Function(Map<String, dynamic> json) parser,
    required Object body,
    bool withAuth = false,
  }) async {
    try {
      final url = Uri.parse('${Constants.apiBase}/$path');

      var headers = withAuth
          ? {
              "Authorization": 'Token ${SessionStore.intance.getSession()}',
              "Origin": Constants.apiBase
            }
          : null;

      final response = await http.post(url, headers: headers, body: body);

      _validate(response);

      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      final T result = parser(jsonResponse);

      return result;
    } on ApiExceptionType {
      rethrow;
    } on SocketException {
      throw ApiException(ApiExceptionType.network);
    } catch (err) {
      print(err);
      throw ApiException(ApiExceptionType.other);
    }
  }

  static void _validate(http.Response response) {
    print(response.statusCode);
    print(response.request?.url.toString());
    if (response.statusCode == 401) {
      throw ApiException(ApiExceptionType.auth);
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ApiException(ApiExceptionType.other);
    }
  }
}

enum ApiExceptionType { network, auth, other }

class ApiException implements Exception {
  final ApiExceptionType type;

  ApiException(this.type);
}
