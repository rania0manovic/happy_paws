import 'package:happypaws/common/services/BaseService.dart';

class ProductCategorySubcategoriesService extends BaseService {
     ProductCategorySubcategoriesService() : super("ProductCategorySubcategories");


  Future<dynamic> getSubcategoryIds(int categoryId) async {
    final response = await get('/GetSubcategoryIdsForCategory?categoryId=$categoryId');
    return response;
  }
   Future<dynamic> getSubcategories(String? categoryId) async {
    final response = await get('/GetSubcategoriesForCategory?categoryId=$categoryId');
    return response;
  }
 
}
