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
    for (var file in data['photoFiles']) {
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
      print(e);
    }
  }

  @override
  Future<dynamic> put(String endpoint,  data) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(baseUrl),
    );
    if (data['photoFiles'] != null) {
      for (var file in data['photoFiles']) {
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
      print(e);
    }
  }
}
