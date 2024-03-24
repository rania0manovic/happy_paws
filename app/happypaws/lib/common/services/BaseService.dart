import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BaseService {
  String baseUrl;
  String? apiUrl = dotenv.env['API_URL'];
  BaseService(String controllerName) : baseUrl = '' {
    baseUrl = apiUrl != null ? "$apiUrl/$controllerName" : '';
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? searchObject}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl$endpoint'),
    );
    return processResponse(response);
  }
    Future<dynamic> getFromQuery(String endpoint,
      {Map<String, dynamic>? searchObject}) async {
    var queryString = '';

    if (searchObject != null) {
      queryString = Uri(queryParameters: searchObject).query;
    }
    final response = await http.get(
      Uri.parse(
          '$baseUrl$endpoint?$queryString'),
    );
    return processResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    return response;
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
    return response;
  }

  Future<dynamic> getPaged(String endpoint, int pageNumber, int pageSize,
      {Map<String, dynamic>? searchObject}) async {
    var queryString = '';
    if (searchObject != null) {
      queryString = Uri(queryParameters: searchObject).query;
    }

    final response = await http.get(
      Uri.parse(
          '$baseUrl/GetPaged?PageNumber=$pageNumber&PageSize=$pageSize&$queryString'),
    );
    return processResponse(response);
  }

  Future<dynamic> postMultiPartRequest(String endpoint, dynamic data) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl),
    );
    if (data['PhotoFile'] != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'PhotoFile',
          data["PhotoFile"],
        ),
      );
    }
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });
    try {
      var response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putMultiPartRequest(String endpoint, dynamic data) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(baseUrl),
    );
    if (data['PhotoFile'] != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'PhotoFile',
          data["PhotoFile"],
        ),
      );
    }
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });
    try {
      var response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  dynamic processResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode==406) {
      return response;
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}
