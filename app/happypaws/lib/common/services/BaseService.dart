import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:happypaws/common/utilities/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

PlatformInfo platformInfo = PlatformInfo();

class BaseService {
  late Dio _dio;
  late String baseUrl;

  String? apiUrl = platformInfo.isDesktopOS()
      ? dotenv.env['API_URL_DESKTOP']
      : dotenv.env['API_URL_MOBILE'];
  BaseService(String controllerName) {
    baseUrl = apiUrl != null ? "$apiUrl/$controllerName" : '';

    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (error, handler) {
          return handler.next(error);
      },
    ));
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? searchObject}) async {
    final response = await _dio.get(
      '$baseUrl$endpoint',
      queryParameters: searchObject,
    );
    return response;
  }

  Future<dynamic> getFromQuery(String endpoint,
      {Map<String, dynamic>? searchObject}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: searchObject,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await _dio.post(
      '$baseUrl$endpoint',
      data: data,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return response;
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    final response = await _dio.put(
      '$baseUrl$endpoint',
      data: data,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return response;
  }

  Future<dynamic> patch(String endpoint, dynamic data) async {
    final response = await _dio.patch(
      '$baseUrl$endpoint',
      data: data,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return response;
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await _dio.delete('$baseUrl$endpoint');
    return response;
  }

  Future<dynamic> getPaged(String endpoint, int pageNumber, int pageSize,
      {Map<String, dynamic>? searchObject}) async {
    final response = await _dio.get(
      '$baseUrl/GetPaged',
      queryParameters: {
        'PageNumber': pageNumber,
        'PageSize': pageSize,
        ...?searchObject,
      },
    );
    return response;
  }
 
}
