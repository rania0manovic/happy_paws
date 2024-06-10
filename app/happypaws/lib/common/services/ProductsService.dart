import 'package:dio/dio.dart';
import 'package:happypaws/common/services/BaseService.dart';

class ProductsService extends BaseService {
  ProductsService() : super("Products");

  Future<dynamic> updateActivityStatus(data) async {
    var response = await patch('/ActivityStatus', data);
    return response;
  }

  Future<dynamic> hasAnyWithCategoryId(int categoryId) async {
    var response = await get('/HasAnyWithCategoryId/$categoryId');
    return response;
  }

  Future<dynamic> hasAnyWithSubcategoryId(int subcategoryId) async {
    var response = await get('/HasAnyWithSubcategoryId/$subcategoryId');
    return response;
  }

  Future<dynamic> hasAnyWithBrandId(int brandId) async {
    var response = await get('/HasAnyWithBrandId/$brandId');
    return response;
  }

  @override
  Future<dynamic> post(String endpoint, data) async {
    FormData formData = FormData();
    if (data['imageFiles'] != null) {
      for (var file in data['imageFiles']) {
        formData.files.add(
          MapEntry(
            'ImageFiles',
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }
    }
    data.forEach((key, value) {
      if (value != null) {
        if (key == 'price') {
          if (value is double) {
            value = value.toString().replaceAll('.', ',');
          } else {
            value = value.replaceAll('.', ',');
          }
        }
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    try {
      var response = await super.post('', formData);
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
      var response = await get("/Bestsellers", searchObject: {"size": size});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(String endpoint, data) async {
    FormData formData = FormData();
    if (data['imageFiles'] != null) {
      for (var file in data['imageFiles']) {
        formData.files.add(
          MapEntry(
            'ImageFiles',
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }
    }
    data.forEach((key, value) {
      if (value != null) {
        if (key == 'price') {
          if (value is double) {
            value = value.toString().replaceAll('.', ',');
          } else {
            value = value.replaceAll('.', ',');
          }
        }
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    try {
      var response = await super.put('', formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
