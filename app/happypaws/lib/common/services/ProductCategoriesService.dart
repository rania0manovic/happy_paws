import 'package:happypaws/common/services/BaseService.dart';
import 'package:http/http.dart' as http;

class ProductCategoriesService extends BaseService {
  ProductCategoriesService() : super("ProductCategories");

  @override
  Future<dynamic> post(String endpoint, dynamic data) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'PhotoFile',
        data["photoFile"],
      ),
    );
    request.fields['SubcategoryIds'] = data["subcategoryIds"].toString();
    request.fields['Name'] = data["name"];
    if (data['addedIds'].length > 0) {
      String subcategoryIdsString = data['addedIds'].join(',');
      request.fields['AddedIds'] = subcategoryIdsString;
    }
    var response = await request.send();
    return response;
  }

  @override
  Future<dynamic> put(String endpoint, dynamic data) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(baseUrl),
    );
    if (data['photoFile'] != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'PhotoFile',
          data["photoFile"],
        ),
      );
    }
    if (data['addedIds']!=null && data['addedIds'].isNotEmpty) {
      String subcategoryIdsString = data['addedIds'].join(',');
      request.fields['AddedIds'] = subcategoryIdsString;
    }
     if (data['removedIds']!=null && data['removedIds'].isNotEmpty) {
      String subcategoryIdsString = data['removedIds'].join(',');
      request.fields['RemovedIds'] = subcategoryIdsString;
    }
    request.fields['Name'] = data["name"];
    request.fields['Id'] = data["id"].toString();
    request.fields['PhotoId'] = data['photo']['id'].toString();
    try {
      var response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
