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
    request.files.add(
      await http.MultipartFile.fromPath(
        'ImageFile',
        data["photoFile"],
      ),
    );
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
}
