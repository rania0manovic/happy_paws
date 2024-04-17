import 'package:happypaws/common/services/BaseService.dart';
import 'package:http/http.dart' as http;

class ProductsService extends BaseService {
  ProductsService() : super("Products");

  @override
  Future<dynamic> post(String endpoint, data) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl),
    );
    for (var file in data['imageFiles']) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'ImageFiles',
          file.path,
        ),
      );
    }
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    try {
      var response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getRecommendedProductsForUser({int size = 5}) async {
    try {
      var response = await get("/RecommendedProductsForUser",
          searchObject: {"size": size});
      return response;
    } catch (e) {
      rethrow;
    }
  }

   Future<dynamic> getBestsellers({int size = 4}) async {
    try {
      var response = await get("/Bestsellers",
          searchObject: {"size": size});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(String endpoint, data) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(baseUrl),
    );
    if (data['imageFiles'] != null) {
      for (var file in data['imageFiles']) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'ImageFiles',
            file.path,
          ),
        );
      }
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
}
