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

  Future<dynamic> sendNewsLetterForNewArrivalls(data) async {
    var response = await post('/SendNewsLetterForNewArrivalls', data);
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

  Future<dynamic> getRecommendedProductsForUser({int size = 5}) async {
    var response =
        await get("/RecommendedProductsForUser", searchObject: {"size": size});
    return response;
  }

  Future<dynamic> getBestsellers({int size = 4}) async {
    var response = await get("/Bestsellers", searchObject: {"size": size});
    return response;
  }
}
