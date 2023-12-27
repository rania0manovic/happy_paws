import 'package:happypaws/common/services/BaseService.dart';
import 'package:http/http.dart' as http;

class ProductSubcategoriesService extends BaseService {
  ProductSubcategoriesService() : super("ProductSubcategories");

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
    request.fields['Name'] = data["name"];
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
    request.fields['Name'] = data["name"];
    request.fields['Id'] = data["id"].toString();
    request.fields['PhotoId']=data['photo']['id'].toString();
    var response = await request.send();
    return response;
  }
}
