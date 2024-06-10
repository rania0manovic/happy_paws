import 'package:happypaws/common/services/BaseService.dart';
import 'package:http/http.dart' as http;

class UsersService extends BaseService {
  UsersService() : super("Users");

  Future<dynamic> getRecommendedProducts() async {
    var response = await get('/RecommendedProducts');
    return response;
  }

  @override
  Future<dynamic> put(String endpoint, data) async {
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
