import 'package:happypaws/common/services/BaseService.dart';

class ProductCategorySubcategoriesService extends BaseService {
     ProductCategorySubcategoriesService() : super("ProductCategorySubcategories");


  Future<dynamic> getSubcategoryIds(int categoryId) async {
    final response = await get('/GetSubcategoryIdsForCategory?categoryId=$categoryId');
    return response;
  }
   Future<dynamic> getSubcategories(String? categoryId, {bool includePhotos=false}) async {
    final response = await get('/GetSubcategoriesForCategory?categoryId=$categoryId&includePhotos=$includePhotos');
    return response;
  }
 
}
